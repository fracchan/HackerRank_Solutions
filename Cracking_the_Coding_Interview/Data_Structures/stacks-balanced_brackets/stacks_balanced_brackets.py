#!/usr/bin/python

def is_matched(expression):
    stack = []
    for p in expression:
        if p == "{":
            stack.append("}")
        elif p == "[":
            stack.append("]")
        elif p == "(":
            stack.append(")")
        else:
            if len(stack) == 0 or stack.pop() != p:
                return False
    return len(stack) == 0 
        
        

t = int(raw_input().strip())
for a0 in xrange(t):
    expression = raw_input().strip()
    if is_matched(expression) == True:
        print "YES"
    else:
        print "NO"

