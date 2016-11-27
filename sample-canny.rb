require 'opencv'
include OpenCV

begin
  src_img = CvMat.load("lenna.png")
rescue
  puts 'Could not open or find the image.'
  exit
end
canny_img = src_img.BGR2GRAY.canny(120,200)
#canny_img = src_img.BGR2GRAY.canny(120,200)

src_window = GUI::Window.new('Input')
canny_window = GUI::Window.new('Output')
src_window.show src_img
canny_window.show canny_img

GUI::wait_key