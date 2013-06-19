class Player < ActiveRecord::Base
  attr_accessible :name

  has_many :tournaments
  has_many :tournament_players
  has_many :tournaments, :through => :tournament_players

  has_and_belongs_to_many :matches
  # has_many :player_matches
  # has_many :matches, :through => :player_matches
    
  validates :name, :presence => true, :uniqueness => true
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