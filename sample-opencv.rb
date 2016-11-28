require 'opencv'
include OpenCV

begin
  src_img = CvMat.load("./image/Lenna.bmp")
rescue
  puts 'Could not open or find the image.'
  exit
end

src_window = GUI::Window.new('Input')
src_window.show src_img

GUI::wait_key