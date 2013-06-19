# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tournament_player, :class => 'TournamentPlayers' do
    player_id 1
    tournament_id 1
  end
end
