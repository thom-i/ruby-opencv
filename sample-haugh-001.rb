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
    src_001.line!(points[0], points[1], :color => CvColor::Red, :thickness => 1)
end

p "===直線検出==="
# 直線座標をy座標順にソート

# 各直線のy座標を取得
line_y_array_all = Array.new
line_array.each {|line_y| line_y_array_all.push(line_y[0].y)}
line_y_array_all.sort!

# 余計な直線情報を削除
line_y_array = Array.new
line_y_array_all.each.with_index(1) do |line, index|
    line_y_array.push(line) if (line_y_array_all[index].to_i - line.to_i) > 2 || index >= line_y_array_all.length
end

p "線分のY座標情報(重複分は削除済み)"
p line_y_array

p "線分の間や五線グループ外の座標を追加"
line_y_array_add = line_y_array.each_slice(5).to_a
p (line_y_array[1] - line_y_array[0]) / 2
p line_y_array_add

# 各五線譜の一番上と一番下の線分を取得
line_y_array.select!.with_index{|e, i| i % 5 == 0 || i % 5 == 4}

# 各五線譜をの左上、右下の頂点を元にrectで囲む
line_y_array.each_slice(2).to_a.each do |v|
    pt1 = CvPoint.new(line_array.first[0].x, v[0])
    pt2 = CvPoint.new(seq.first[1].x, v[1])
    src_002 = src_002.rectangle(pt1, pt2, :color => CvColor::Red, :thickness => 3)
end

# pt1 = CvPoint.new(line_array.first[0].x, line_y_array[0])
# pt2 = CvPoint.new(seq.first[1].x, line_y_array[1])
# src_002 = src.rectangle(pt1, pt2, :color => CvColor::Red, :thickness => 3)

# # ウィンドウを作成して表示
# GUI::Window.new("src").show(src)
# GUI::Window.new("dst").show(gray_img)
# GUI::Window.new("src_001").show(src_001)
GUI::Window.new("src_001").show(src_001)
GUI::Window.new("src_002").show(src_002)
GUI::wait_key