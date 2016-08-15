class User < ActiveRecord::Base
  include BCrypt

  # put assosiations here

  validates_presence_of :username, :email, :password
  validates_uniqueness_of :username, :email

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

  private

  def validate_password
    if @raw_password.nil?
      errors.add(:password, "is required")
    elsif @raw_password.length < 6
      errors.add(:password, "must be longer than 6 characters")
    end
  end
end
