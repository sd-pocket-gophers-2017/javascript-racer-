class Game < ActiveRecord::Base
  has_many :game_players
  has_many :players, through: :game_players
  belongs_to :winner, class_name: 'Player'

  validates :url, uniqueness: true, presence: true
  validate :only_two_players
  before_validation :generate_url

  def only_two_players
    if self.players.length != 2
      errors.add(:players, 'must be two')
    end
  end

  def generate_url
    self.url = SecureRandom.urlsafe_base64(5)
  end
end
