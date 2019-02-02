require 'opencv'
include OpenCV

src_img = CvMat.load('./image/temp_orig_small.png')
result_img = CvMat.load('./image/temp_orig_small.png')
tmp_img_001 = CvMat.load('./image/temp_orig_small_001.png')
tmp_img_002 = CvMat.load('./image/temp_orig_small_002.png')
tmp_img_003 = CvMat.load('./image/temp_orig_small_003.png')

$symbol_array = Array.new

def tmp_match(src_img, tmp_img, threshold_num, color, symbol_label)
    result_img = src_img
    50.times{
        result = src_img.match_template(tmp_img, CV_TM_CCOEFF_NORMED)
        # マッチ度のしきい値が下回れば抜ける
        break if result.min_max_loc[1] < threshold_num
        pt1 = CvPoint.new(result.min_max_loc[3].x - 1, result.min_max_loc[3].y - 1)
        pt2 = CvPoint.new(pt1.x + tmp_img.width, pt1.y + tmp_img.height)
        
        # マッチした部分を囲う
        result_img = result_img.rectangle(pt1, pt2, :color => color, :thickness => 2)

        # マッチした部分を塗りつぶす
        src_img = src_img.rectangle(pt1, pt2, :color => color, :thickness => -1)

        # 記号の中心座標を取得して格納(x軸, y軸, 記号のラベル)
        $symbol_array.push([pt1.x+(tmp_img.width/2), pt1.y + (tmp_img.height/2), symbol_label])
    }
    return result_img
end

# 入力画像, テンプレート画像, しきい値, 描画する色, どの記号なのかのラベル
rst = tmp_match(src_img, tmp_img_001, 0.80, CvColor::Yellow, 1)
rst = tmp_match(rst,     tmp_img_002, 0.80, CvColor::Green,  2)
rst = tmp_match(rst,     tmp_img_003, 0.80, CvColor::Blue,   3)

GUI::Window.new('src_img').show(src_img)
GUI::Window.new('result_img').show(rst)
GUI::wait_key