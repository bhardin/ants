class Player < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true, :uniqueness => true

  has_many :tournaments
  has_many :tournament_players
  has_many :tournaments, :through => :tournament_players
  has_and_belongs_to_many :matches

  def has_played?(player)
    return false if matches.nil?

    matches.each do | match |
      if match.player_1.name == self.name 
        if match.player_2.name == player.name
          return true
        end
      else
        if match.player_1.name == player.name
          return true
        end
      end
    end

    return false
  end

  def has_not_played?(player)
    !has_played?(player)
  end
end


  # Tournament | Match | Player | Round 
  # ------------------------------------
  #     1     |   1   |    1    |   1
  # ------------------------------------
  #     1     |   1   |    2    |   1
  # ------------------------------------
  #     1     |   2   |    3    |   1
  # ------------------------------------
  #     1     |   2   |    4    |   1
  # ------------------------------------
  #     1     |   3   |    5    |   1
  # ------------------------------------
  #     1     |   3   |    6    |   1
  # ------------------------------------
  #     1     |   4   |    1    |   2
  # ------------------------------------
  #     1     |   4   |    3    |   2