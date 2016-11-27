require 'opencv'
include OpenCV

#data = '/usr/local/Cellar/opencv/2.4.13.1/share/OpenCV/haarcascades/haarcascade_frontalface_alt_fix.xml'
data = 'haarcascade_frontalface_alt.xml'
detector = CvHaarClassifierCascade::load(data)
src_img = CvMat.load("Lenna.bmp")
detector.detect_objects(src_img).each do |region|
  src_img.rectangle!(region.top_left, region.bottom_right, :color => color = CvColor::Blue, :thickness => 3)
end

GUI::Window.new('Result').show(src_img)
GUI::wait_key