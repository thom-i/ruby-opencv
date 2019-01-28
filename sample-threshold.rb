require 'opencv'
include OpenCV

# 画像をロード
src = CvMat.load("./image/score/kirakira/001.bmp")
src_001 = CvMat.load("./image/score/kirakira/001.bmp")
src_002 = CvMat.load("./image/score/kirakira/001.bmp")

# グレースケール、二値化処理
gray_img = src.BGR2GRAY.threshold(200, 255, CV_THRESH_BINARY_INV)

# 確率的ハフ変換で直線検出
seq = gray_img.hough_lines(CV_HOUGH_PROBABILISTIC, 1, Math::PI / 180, 50, 50, 10)

# 検出した直線の座標情報を配列で保持
line_array = Array.new

# 検出した直線を描画
seq.each do |points|
    # puts points[0].y, line_array.last[0].y if !line_array.empty? && (points[0].y line_array.last[0].y)
    line_array = line_array.push(points)
    # puts points[0].y
    p "==="
    p points
    p "=="

    p *points
    p "==="
    src_001.line!(points[0], points[1], :color => CvColor::Red, :thickness => 1)
end

GUI::Window.new("src_001").show(src_001)
# GUI::Window.new("src_001").show(src_001)
# GUI::Window.new("src_002").show(src_002)
GUI::wait_key