require 'opencv'
include OpenCV

src_img = CvMat.load("./image/Lenna.bmp")
canny_img = src_img.BGR2GRAY.canny(120,200)

GUI::Window.new('Input').show(src_img)
GUI::Window.new('Output').show(canny_img)

GUI::wait_key