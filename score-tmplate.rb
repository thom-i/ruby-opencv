require 'opencv'
include OpenCV

src_img = CvMat.load('./image/score/kirakira/001.bmp')
result_img = CvMat.load('./image/score/kirakira/001.bmp')
tmp_img_001 = CvMat.load('./image/score/kirakira/tem_1.bmp')
tmp_img_002 = CvMat.load('./image/score/kirakira/tem_2.bmp')
tmp_img_003 = CvMat.load('./image/score/kirakira/tem_3.bmp')
tmp_img_004 = CvMat.load('./image/score/kirakira/tem_4.bmp')
tmp_img_005 = CvMat.load('./image/score/kirakira/tem_5.bmp')

def tmp_match(src_img, tmp_img, threshold_num, color)
    result_img = src_img
    50.times{
        result = src_img.match_template(tmp_img, CV_TM_CCOEFF_NORMED)
        # マッチ度のしきい値が下回れば抜ける
        break if result.min_max_loc[1] < threshold_num
        p result.min_max_loc[2].x, result.min_max_loc[2].y
        p result.min_max_loc[3].x, result.min_max_loc[3].y
        pt1 = CvPoint.new(result.min_max_loc[3].x - 1, result.min_max_loc[3].y - 1)
        pt2 = CvPoint.new(pt1.x + tmp_img.width + 2, pt1.y + tmp_img.height + 2)
        # マッチした部分を囲う
        result_img = result_img.rectangle(pt1, pt2, :color => color, :thickness => 2)

        # マッチした部分を塗りつぶす
        src_img = src_img.rectangle(pt1, pt2, :color => color, :thickness => -1)

    }
    return result_img
end

# 入力画像, テンプレート画像, しきい値, 描画する色
rst = tmp_match(src_img, tmp_img_001, 0.8, CvColor::Yellow)
rst = tmp_match(rst, tmp_img_002, 0.8, CvColor::Green)
rst = tmp_match(rst, tmp_img_003, 0.8, CvColor::Blue)
rst = tmp_match(rst, tmp_img_004, 0.90, CvColor::Red)
rst = tmp_match(rst, tmp_img_005, 0.95, CvColor::Red)

GUI::Window.new('src_img').show(src_img)
GUI::Window.new('tmp_img').show(tmp_img_001)
GUI::Window.new('result_img').show(rst)
GUI::wait_key