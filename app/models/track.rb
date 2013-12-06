class Track < ActiveRecord::Base
  attr_writer :duration_str
  belongs_to :album, counter_cache: true
  validates :name, presence: true
  validates :duration_str, presence: true
  validate :wellformed_duration_str
  before_validation :set_duration_str, if: '@duration_str.nil?'
  after_validation :duration_str_to_i, unless: '@duration_str.blank?'

  acts_as_list scope: :album

  def duration_str
    @duration_str ||= self.duration ? Time.at(self.duration).utc.strftime("%H:%M:%S") : ''
  end

  def wellformed_duration_str
    components = @duration_str.split(':')
    errors.add(:duration_str, 'duration needs to be in the format hh:mm:ss') && return if components.count == 1
    components.each do |component|
      if (false if Float(component) rescue true)
        errors.add :duration_str, 'duration needs to be in the format hh:mm:ss'
        return
      end
    end
  end

  def set_duration_str
    @duration_str = ''
  end

  def duration_str_to_i
    s = 0
    components = %w(hours minutes seconds)
    duration_str.split(':').reverse.each do |component|
      s += component.to_i.send components.pop
    end
    self.duration = s
  end
end
