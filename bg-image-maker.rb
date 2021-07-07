require "mini_magick"

MiniMagick::Tool::Convert.new do |i|
  i.size "1200x600"
  i.gravity "center"
  i.xc '#F3F4F6'
  i.bordercolor '#9CA3AF'
  i.border "20x20"
  i.bordercolor '#E5E7EB'
  i.border "12x12"
  i << "test_image.jpg"
end
