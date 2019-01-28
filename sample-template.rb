require 'opencv'
include OpenCV

src_img = CvMat.load('./image/char_sample.png')
tmp_img = CvMat.load('./image/char_tmp.png')

result = src_img.match_template(tmp_img, CV_TM_SQDIFF)

pt1 = result.min_max_loc[2]
pt2 = CvPoint.new(pt1.x + tmp_img.width, pt1.y + tmp_img.height)
p pt1.x, pt1.y
result_img = src_img.rectangle(pt1, pt2, :color => CvColor::Red, :thickness => 3)

GUI::Window.new('src_img').show(src_img)
GUI::Window.new('tmp_img').show(tmp_img)
GUI::Window.new('result_img').show(result_img)
GUI::wait_key