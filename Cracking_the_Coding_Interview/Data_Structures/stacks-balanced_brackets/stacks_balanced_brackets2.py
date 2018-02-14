#!/usr/bin/python

def is_matched(expression):
    stack = []
    pairs = {'{' : '}', '[' : ']', '(' : ')'}
    for p in expression:
        if pairs.get(p):
            stack.append(pairs[p])
        elif len(stack) == 0 or stack.pop() != p:
                return False
    return len(stack) == 0 
        
        

t = int(raw_input().strip())
for a0 in xrange(t):
    expression = raw_input().strip()
    if is_matched(expression) == True:
        print "YES"
    else:
        print "NO"

