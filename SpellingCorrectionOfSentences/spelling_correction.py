#!/usr/bin/env python
# -*- coding: utf-8 -*-
#Şeyma CENGİZ

# By using the METU-Sabanci Turkish Treebank (MSTT) you loaded into a database,
# write a python function to perform a simple spelling correction in Turkish.
#   1.	Read a word from the input, s. 
#   2.	Retrieve all words from MSTT whose length is between |s|-1 and |s|+1 and whose first two letters are the same as the first two letters of s.
#   3.	Calculate edit distances between s and all the words retrieved in Step 2.
#   4.	Print the words whose edit distance is 1.

from __future__ import division
import math
import mysql.connector
import xml.etree.ElementTree as ET
import os

#connection to mysql database
db=mysql.connector.connect(host='hostname',database='databaseName',user='root',password='psw')
cursor = db.cursor()
cursor.execute("SELECT VERSION()")
data = cursor.fetchone()
print "Database version : %s " % data
#(len(letters)-1,len(letters)+1))
word = raw_input("Enter a word : ")
w= ' '+ word[0]+word[1]+'%' # not run without empty string(' ') 
print "first two letters :%s"%(w)
letters = word.strip()
print "number of letters : %d" %(len(letters))

#retrieve all possible words
cursor.execute("SELECT word FROM table WHERE word LIKE %s AND (LENGTH(word)>= %s AND LENGTH(word)<= %s )",(w,len(letters)-1,len(letters)+1+1))#+1 due to empty string  
result = cursor.fetchall()
result_set= set(result)
print "\nPossible words :"
for row in result_set:
    print "%s"%(row)

#edit distance
def edit_distance(s1, s2):
    ls1=len(s1)+1
    ls2=len(s2)+1
    tbl = {}
    for i in range(ls1): tbl[i,0]=i
    for j in range(ls2): tbl[0,j]=j
    for i in range(1, ls1):
        for j in range(1, ls2):
            cost = 0 if s1[i-1] == s2[j-1] else 1
            tbl[i,j] = min(tbl[i, j-1]+1, tbl[i-1, j]+1, tbl[i-1, j-1]+cost)

    return tbl[i,j]

word = ' '+ word
#calculate edit distance
print "\nEdit Distance for 1"
for row in result_set:
    s = row[0]
    ed = edit_distance(s, word)
    if ed == 1:
       print "s : %s \t word : %s \t distance : %d "%(s ,word, ed)


##SHOWING THE EXPECTED RESULTS
print "\nGirilen kelime : %s"% word
print "Bunlardan birini mi demek istediniz"
for row in result_set:
    s = row[0]
    ed = edit_distance(s, word)
    if ed == 1:
       print "%s" %(s)

