class Match < ActiveRecord::Base
  belongs_to :tournament
  
  has_and_belongs_to_many :players
  # has_many :player_matches
  # has_many :players, :through => :player_matches

  attr_accessible :status, :round
  attr_accessible :game_1_score, :game_2_score

  def finished?
    self.status == "finished"
  end

  def update_score(match, params)
    if params["game_1_score"]
      temp_score = params["game_1_score"].tr(' ', '').split("-")
      self.player_1_game_1_score = temp_score[0]
      self.player_2_game_1_score = temp_score[1]
      self.status = "Game 1 Finished"
    elsif params["game_2_score"]
      temp_score = params["game_2_score"].tr(' ', '').split("-")
      self.player_1_game_2_score = temp_score[0]
      self.player_2_game_2_score = temp_score[1]
      self.status = "Game 2 Finished"
    end

    self.save
  end

  def player_1
    players.first
  end

  def player_2
    players.second
  end

  def game_1_score
    "#{player_1_game_1_score} - #{player_2_game_1_score}"
  end

  def game_2_score
    "#{player_1_game_2_score} - #{player_2_game_2_score}"
  end

  def player_1_match_points
    player_1_game_1_score + player_1_game_2_score
  end

  def player_2_match_points
    player_2_game_1_score + player_2_game_2_score
  end

  def went_to_time?
    (player_1_game_1_score != 10 && player_2_game_1_score != 10) || 
    (player_1_game_2_score != 10 && player_2_game_2_score != 10)
  end

  def finished_in_time?
    (player_1_game_1_score == 10 || player_2_game_1_score == 10) && 
    (player_1_game_2_score == 10 || player_2_game_2_score == 10)
  end

  def player_prestige(player)
    prestige = Array.new(2, 0)

    # Count Game 1
    if player_1_game_1_score > player_2_game_1_score
      prestige[0] += 2
    elsif player_1_game_1_score < player_2_game_1_score
      prestige[1] += 2
    elsif player_1_game_1_score == player_2_game_1_score
      prestige[0] += 1
      prestige[1] += 1
    end

    # Count Game 2
    if finished_in_time?
      if player_1_game_2_score > player_2_game_2_score
        prestige[0] += 2
      elsif player_1_game_2_score < player_2_game_2_score
        prestige[1] += 2
      elsif player_1_game_2_score == player_2_game_2_score
        prestige[0] += 1
        prestige[1] += 1
      end
    else
      prestige[0] += 1
      prestige[1] += 1
    end

    # Count The totals
    if player_1_match_points > player_2_match_points
      prestige[0] += 2
    elsif player_1_match_points < player_2_match_points
      prestige[1] += 2
    elsif player_1_match_points == player_2_match_points
      prestige[0] += 1
      prestige[1] += 1
    end

    return prestige[0] if player == 1
    return prestige[1] if player == 2
  end
end

# class MatchValidator < ActiveModel::Validator
#   def validate(record)
#     if record.player_missing?
#       record.errors[:base] << "Player is missing"
#     end
#   end
# end
