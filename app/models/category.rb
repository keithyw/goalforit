class Category < ActiveRecord::Base
  has_many :goals
  validates :name, presence: true,
                  length: { minimum: 3 }
end
