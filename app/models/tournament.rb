class Tournament < ActiveRecord::Base
  attr_accessible :name, :status, :round

  has_many :matches
  # has_many :players

  has_many :tournament_players
  has_many :players, :through => :tournament_players

  # def initalize
  #   self.status = "Adding Players"
  # end

  def start_tournament
    raise Error if running?

  	self.status = "running"
    seed_first_round
  end

  def current_round
    round
  end

  def end_tournament
  	self.status = "finished"
  end

  def can_add_players?
  	return false if running?
  	return true
  end

  def next_round
    unless self.round == total_number_of_rounds
      self.round += 1
      self.save
      calculate_each_players_prestige
      match_players(players_sorted_by_prestige)
    else
      end_tournament
    end
  end

  def all_matches_finished?
    self.matches.each do | m |
      puts m.status
      if m.status != :finished
        puts false
        return false
      end
    end

    puts true
    return true
  end

  def seed_first_round
    self.round = 1

  	@players = self.players
  	if @players.count.odd?
  		self.players << Player.find_or_create_by_name("BYE")
      self.save
  	end

  	@players.shuffle!

    match_players(@players)
  end

  def match_players(players)
    temp_players = Array.new(players).reverse
    i = 0
    temp_array = []
    
    while i < players.count
      player_1 = temp_players.pop
      player_2 = temp_players.pop
      until player_1.has_not_played?(player_2)
        temp_array << player_2
        player_2 = temp_players.pop
      end
      temp_players += temp_array.reverse
      player1 = players.at(i)
      player2 = players.at(i+1)
      create_match(player1, player2, self.round, self)
      i += 2
    end
  end

  def create_match(player1, player2, round, tournament)
    match = Match.new
    match.players << player1
    match.players << player2
    match.round = round
    match.tournament = tournament
    match.save
  end

  # This should be used for single-elimination after
  # the swiss matches have been played.
  def match_players_first_to_last(players)
    count = (players.count/2)

    count.times do | i |
      player1 = players[i]
      player2 = players[players.count - 1 - i]
      create_match(player1, player2, self.round, self)
    end
  end

  # From Fantasy Flight Organized Play Rules
  # Players     Full # of Rounds       Min # of Rounds of Play
  #             if not cutting to      Before cutting to 
  #             Single-Elimination     Single-Elimination
  # 2 - 4       2                      N/A
  # 5 - 8       3                      N/A
  # 9 - 16      4                      N/A
  # 17 - 32     5                      3, Cut to Top-4
  # 33+         6                      4, Cut to Top-8
  def total_number_of_rounds
    case player_count
    when 2..4
      2
    when 5..8
      3
    when 9..16
      4
    when 17..32
      5
    else
      6
    end
  end

  # Returns a list of players sorted by prestige. The first player will have the hightest prestige and the last player will have the smallest.
  def tournament_players_sorted_by_prestige
    TournamentPlayer.where(:tournament_id => self.id).order("prestige DESC").order("match_points DESC")
  end

  def players_sorted_by_prestige
    sorted_players = []

    tournament_players_sorted_by_prestige.each do | p |
      sorted_players << Player.find(p.player_id)
    end

    return sorted_players
  end

  def finished?
    status == "finished"
  end

  def running?
    status == "running"
  end

  private
  def player_count
    self.players.count
  end

  def calculate_each_players_prestige
    @players = self.players

    @players.each do | p |
      match = p.matches.last
      player_one = match.players.first
      player_two = match.players.second

      if player_one == p
        prestige = match.player_prestige(1)
        match_points = match.player_1_match_points
      elsif player_two == p
        prestige = match.player_prestige(2)
        match_points = match.player_2_match_points
      else
        Raise "error"
      end

      tp = TournamentPlayer.where(:player_id => p.id, :tournament_id => self.id).first
      tp.prestige += prestige
      tp.match_points += match_points
      tp.save

      puts "#{p.name} #{tp.prestige}: #{player_one.name} vs. #{player_two.name}"   
    end
  end
end
