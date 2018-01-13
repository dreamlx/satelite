# README


####	pip install -r requirements.txt。#安装必要组件
####	所有分类放在 jpg_images文件夹下，每个分类（子文件夹）只放一种类型的图片。
####	重新训练模型时执行脚本：python retrain.py
####	得到的输出为  ./tmp/output_graph.pb 和 ./tmp/output_labels.txt,将上面两个文件替换原来的模型即可
####	测试新训练的模型识别图像脚本：python  retrain_model_classifier.py --./image_path/xxx/xxx.jpg
