class Album < ActiveRecord::Base
  belongs_to :artist
  validates :name, presence: true
  has_many :tracks
  has_and_belongs_to_many :users
end
