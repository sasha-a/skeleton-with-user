class User < ActiveRecord::Base
  include BCrypt

  has_many :subscriptions
  has_many :channels, through: :subscriptions

  validates_presence_of :email, :password
  validates_uniqueness_of :email

  validate :validate_password

  # users.password_hash in the database is a :string
  def password
    @password ||= Password.new(hashed_password)
  end

  def password=(new_password)
    @raw_password = new_password
    @password = Password.create(new_password)
    self.hashed_password = @password
  end

  def authenticate(password)
    self.password == password
  end

  def total_per_month
      self.channels.map(&:price_per_month).reduce(:+)
  end

  # def subscribed?(channel)
  #   self.subscriptions.map(&:channel_id).include?(channel.id)
  # end

  private

  def validate_password
    if @raw_password.nil?
      errors.add(:password, "is required")
    elsif @raw_password.length < 6
      errors.add(:password, "must be longer than 6 characters")
    end
  end
end
