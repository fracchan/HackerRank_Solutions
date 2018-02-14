#!/usr/bin/python

from collections import Counter 

m, n = map(int, raw_input().strip().split(' '))
magazine = raw_input().strip().split(' ')
ransom = raw_input().strip().split(' ')
print "Yes" if len(Counter(ransom)-Counter(magazine))==0 else "No"
