class Obit < ActiveRecord::Base
  validates :name, presence: true
  validates :obituary, presence: true
  
  belongs_to :user
end
