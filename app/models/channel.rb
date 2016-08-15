class Channel < ActiveRecord::Base
  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :user

  def total_subscribers
    self.subscribers.length
  end
end
