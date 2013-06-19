class PlayerMatch < ActiveRecord::Base
  attr_accessible :match_id, :player_id, :tournament_id

  has_many :players
  belongs_to :match
  belongs_to :tournament

  # validates :second_game_score, :numericality => { 
  # 	:less_than_or_equal_to => 10, 
  # 	:greater_than_or_equal_to => 0 }
end
