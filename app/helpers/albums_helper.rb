module AlbumsHelper
  def number_to_duration number
    hours = number / 3600
    mins = (number % 3600) / 60
    secs = number % 60
    d = ''
    [hours, mins, secs].each_with_index do |t, i|
      t = t.to_s.rjust(2, '0')
      d << (i != 2 ? "#{t}:" : "#{t}")
    end
    d
  end
end
