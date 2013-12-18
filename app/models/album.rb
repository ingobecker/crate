class Album < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks
  belongs_to :artist
  validates :name, presence: true
  has_many :tracks
  has_and_belongs_to_many :users
  accepts_nested_attributes_for :artist, :tracks
  has_attached_file :cover, :styles => { :medium => '300x300>', :thumb => '100x100>', :tiny => '50x50>' }, :default_url => ':style_cover.png'
  validates_attachment :cover, content_type: {:content_type => /^image\/(png|gif|jpeg)/}, size: {in: 0..2.megabytes}

  mapping do
    indexes :id
    indexes :name
    indexes :user_ids, as: 'user_ids'
    indexes :artist, as: 'artist.name'
  end

  def self.search(options)
    tire.search do
      query do
        string "*#{options[:q]}*"
      end
      filter :terms, user_ids: [options[:user].id] if options.key? :user
    end
  end
end
