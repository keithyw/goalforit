class Goal < ActiveRecord::Base
  belongs_to :category
  validates :goal, presence: true,
                  length: { minimum: 3 }
  validates :completed, numericality: { only_integer: true }
  validates :finish_time, numericality: { only_integer: true }
end
