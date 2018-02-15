#!/usr/bin/python

# Didn't implement a complete trie.
# Started with a dictionary of contacts, where key is the first character


class Contacts(object):
    def __init__(self):
        self.contacts = {}

    def add_contact(self,name):
        if name[0] not in self.contacts:
            self.contacts[name[0]] = set()   
        self.contacts[name[0]].add(name)
        
    def find_partial(self, partial):
        if partial[0] not in self.contacts:
            return 0
        else:
            counter = 0
            for name in self.contacts[partial[0]]:
                if partial == name[0:len(partial)]:
                    counter += 1       
        return counter
    

n = int(raw_input().strip())
c = Contacts()
for a0 in xrange(n):
    op, contact = raw_input().strip().split(' ')
    if op == 'add':
        c.add_contact(contact)
    else: #find
        print c.find_partial(contact)
