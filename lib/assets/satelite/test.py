
#import tensorflow as tf
#node1 = tf.constant(3.0, dtype=tf.float32)
#node2 = tf.constant(4.0) # also tf.float32 implicitly
#sess = tf.Session()
#print(sess.run([node1, node2]))
#print('test23423432')
#a=params
#print(type(a))
import sys
#print("脚本名：", sys.argv[1])
#print(type(sys.argv[1].split(',')))
#for i in range(1, len(sys.argv)):
 #   print("参数", i, sys.argv[i])
for i in sys.argv[1].split(','):
   print(i)
