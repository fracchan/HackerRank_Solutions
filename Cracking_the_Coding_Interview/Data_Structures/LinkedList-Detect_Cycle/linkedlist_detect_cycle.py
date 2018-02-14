"""
Detect a cycle in a linked list. Note that the head pointer may be 'None' if the list is empty.

A Node is defined as: 
 
    class Node(object):
        def __init__(self, data = None, next_node = None):
            self.data = data
            self.next = next_node
"""

def has_cycle(head):
    # useless already in the while loop
    # if (head == None):
    #    return False
    memory_position = []
    current = head
    while (current != None):
        if (id(current) in memory_position):
            return True
        memory_position.append(id(current))
        current = current.next
    return False
    # return True if len(memory_position) == len(set(memory_position)) else False - no way to get out infinite loop
        
