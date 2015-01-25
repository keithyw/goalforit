class Profile < ActiveRecord::Base
  class << columns_hash['birthday']
    def type
      :date
    end
  end

  before_save { self.username = username.downcase }
  belongs_to :user
  validates :username, length: { maximum: 50 },
                    uniqueness: { case_sensitive: false }
  validates :first_name, length: { maximum: 50 }
  validates :last_name, length: { maximum: 50 }
end