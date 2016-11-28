require 'opencv'
include OpenCV

src_img = CvMat.load('../image/Lenna_small.bmp')
gray_img = src_img.BGR2GRAY
bin_img = gray_img.threshold(128, 255, :binary)
canny_img = src_img.BGR2GRAY.canny(120,200)

GUI::Window.new('src').show(src_img)
GUI::Window.new('gray').show(gray_img)
GUI::Window.new('bin').show(bin_img)
GUI::Window.new('canny').show(canny_img)

GUI::wait_key