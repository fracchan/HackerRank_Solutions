""" Node is defined as
class node:
    def __init__(self, data):
        self.data = data
        self.left = None
        self.right = None
"""

import sys

def checkBST(root):
    return check(root, -sys.maxint-1,sys.maxint)
 
def check(node, min, max):
    if node == None:
        return True
    if node.data <= min or node.data >= max:
        return False
    return check(node.left, min, node.data) and check(node.right, node.data, max)
      
