class Track < ActiveRecord::Base
  belongs_to :album, counter_cache: true
  validates :name, presence: true

  acts_as_list scope: :album
end
