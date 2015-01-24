class Goal < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :goal, presence: true,
                  length: { minimum: 3 }
  validates :user_id, presence: true                
  validates :completed, numericality: { only_integer: true }
  validates :finish_time, numericality: { only_integer: true }
end
