class Job < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  scope :recent, -> {order(updated_at: :desc)}
end
