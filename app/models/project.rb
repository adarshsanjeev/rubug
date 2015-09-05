class Project < ActiveRecord::Base
  validates :title, presence: true
  validates :description, presence: true
  validates :is_public, presence: true
  belongs_to :user
  has_many :permissions
end
