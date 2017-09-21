# -*- coding: utf-8 -*-
import sys
import os
import tensorflow as tf
from PIL import Image

# image_paths = sys.argv[1]

# Read in the image_data
# image_data = tf.gfile.FastGFile(image_path, 'rb').read()

# Loads label file, strips off carriage return
label_lines = [line.rstrip() for line
               in tf.gfile.GFile("lib/assets/satelite/output_dir/satellite_labels.txt")]

# Unpersists graph from file
with tf.gfile.FastGFile("lib/assets/satelite/output_dir/satellite_graph.pb", 'rb') as f:
    graph_def = tf.GraphDef()
    graph_def.ParseFromString(f.read())
    _ = tf.import_graph_def(graph_def, name='')

with tf.Session() as sess:
    # Feed the image_data as input to the graph and get first prediction
    softmax_tensor = sess.graph.get_tensor_by_name('final_result:0')

    result = {}
    # 遍历目录
    for image_path in sys.argv[1].split(','):
        # for index, image_path in enumerate(['images/test_images/beach.jpg', 'images/test_images/beach1.jpeg']):
        result[image_path] = []
        image_data = tf.gfile.FastGFile(image_path, 'rb').read()
        predictions = sess.run(softmax_tensor, {'DecodeJpeg/contents:0': image_data})
        top_k = predictions[0].argsort()[-2:][::-1]
        for node_id in top_k:
            human_string = label_lines[node_id]
            score = predictions[0][node_id]
            result[image_path].append({"type": human_string, "score": score})
            #print('%s (score = %.5f)' % (human_string, score))
    print(result)
