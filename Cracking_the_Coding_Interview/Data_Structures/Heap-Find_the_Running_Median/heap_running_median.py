#!/usr/bin/python

# heapq.heappush(heap, item)
# Push the value item onto the heap, maintaining the heap invariant.

# heapq.heappop(heap)
# Pop and return the smallest item from the heap, maintaining the heap invariant. 
# If the heap is empty, IndexError is raised. 
# To access the smallest item without popping it, use heap[0].

# heapq.heappushpop(heap, item)
# Push item on the heap, then pop and return the smallest item from the heap. 
# The combined action runs more efficiently than heappush() followed by a separate call to heappop().

import sys
import heapq
# note: heapq is only a min_heap 
# to store a max_heap we make the upper half value negative numbers so the minimum is actually -max_value


class my_heap(object):
    def __init__(self):
        self.lower = [] #max_heap
        self.upper = [] #min_heap
    
    def median(self):
        if len(self.lower) == len(self.upper):
            # we do not sum the two values since the values store are negative
            return (self.upper[0] - self.lower[0] )/2.0
        else:
            return -self.lower[0]
        
    
    def add(self, value):
            if len(self.lower) == len(self.upper): # add to lower
                if not self.lower or value < self.upper[0]:
                    heapq.heappush(self.lower, -value)
                else:
                    min_upper = heapq.heappushpop(self.upper,value)
                    heapq.heappush(self.lower, - min_upper)
            else: # len(self.lower) - len(self.upper) == 1 # add to upper
                if value > -self.lower[0]:
                    heapq.heappush(self.upper, value)
                else:
                    max_lower = -heapq.heappushpop(self.lower,-value)
                    heapq.heappush(self.upper, max_lower)
             
   
n = int(raw_input().strip())
a = my_heap()
a_i = 0
for a_i in xrange(n):
    a_t = int(raw_input().strip())
    a.add(a_t)
    print round(a.median(),1)
