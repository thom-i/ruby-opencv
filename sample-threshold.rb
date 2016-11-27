require 'opencv'
include OpenCV

src_img = CvMat.load('Lenna.bmp')
gray_img = src_img.BGR2GRAY
bin_img = gray_img.threshold(128, 255, :binary)

src_window = GUI::Window.new('src')
gray_window = GUI::Window.new('gray')
bin_window = GUI::Window.new('bin')

src_window.show(src_img)
gray_window.show(gray_img)
bin_window.show(bin_img)

GUI::wait_key