class TournamentPlayer < ActiveRecord::Base
  attr_accessible :player_id, :tournament_id
  attr_accessible :prestige, :match_points

  belongs_to :player
  belongs_to :tournament

  def name
  	self.player.name
  end
end
