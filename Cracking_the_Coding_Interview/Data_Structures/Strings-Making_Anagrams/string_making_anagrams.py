#!/usr/bin/python
import string

def number_needed(a, b):
    d = dict.fromkeys(string.ascii_lowercase, 0)
    for i in a:
        d[i] += 1
    for j in b:
        d[j] -= 1

    return sum(abs(x) for x in d.values())    
        
a = raw_input().strip()
b = raw_input().strip()

print number_needed(a, b)

