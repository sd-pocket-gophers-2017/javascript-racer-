class Game < ActiveRecord::Base
  has_many :game_players
  has_many :players, through: :game_players

  validates :url, uniqueness: true, presence: true
  validate :only_two_players
  before_validation :url

  def only_two_players
    if self.players.length != 2
      errors.add(:players, 'must be two')
    end
  end

  def url
    self.url = SecureRandom.urlsafe_base64(5)
  end
end
