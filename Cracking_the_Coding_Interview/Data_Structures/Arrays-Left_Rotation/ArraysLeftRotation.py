#!/usr/bin/python
# a - input list
# n - list length
# k - left rotation
def array_left_rotation(a, n, k):
    temp =[0]*n
    for i in range(n):
        temp[(i+n-k)%n] = a[i]
    return temp
  

n, k = map(int, raw_input().strip().split(' '))
a = map(int, raw_input().strip().split(' '))
answer = array_left_rotation(a, n, k);
print ' '.join(map(str,answer))

