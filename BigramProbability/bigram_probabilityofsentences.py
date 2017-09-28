#!/usr/bin/env python
# -*- coding: utf-8 -*-
#Şeyma CENGİZ

# By using the METU-Sabanci Turkish Treebank (MSTT) you loaded into a database, write a python function to answer the following:
# Given a sentence with any number of words, calculate the bigram probability of the input sentence by using the conditional probabilities of its bigrams from the corpus

from __future__ import division
import math
import mysql.connector
import xml.etree.ElementTree as ET
import os
#connection to mysql database
db=mysql.connector.connect(host='hostName',database='databaseName',user='root',password='psw')
cursor = db.cursor()
cursor.execute("SELECT VERSION()")
data = cursor.fetchone()
print "Database version : %s " % data


sentence = "Ben bu sabah erken uyandim"
words = sentence.split(" ")
for i in range(0,len(words)-1):
# SECTION A
    # Select count(*) from MSTT where word like “bu”
    # Should give you the frequency of seni in the corpus.
    print(words[i],words[i+1])
    word ='%'+ words[i]+'%'
    nextword ='%'+ words[i+1]+'%'
    #print (word)
    cursor.execute("SELECT COUNT(*)FROM table WHERE word LIKE %s ",(word,))
    resultA = cursor.fetchall()[0]
    print "The frequency of initial word = %d" % (resultA)

# SECTION B
    # The following query should give the number of daha that immediately follows “bu”
    # Select COUNT(*) from MSTT as R INNER JOIN (select fname, SNO, IX, Word from MSTT where word like “bu”) AS T where R.fname = T.fname AND R.SNO = T.SNO AND R.IX = T.IX + 1 and R.Word like 'daha'
    cursor.execute( "SELECT COUNT(*) FROM table AS R \
                   INNER JOIN (SELECT FILENAME, SN, IX, WORD FROM table WHERE WORD LIKE %s) AS T \
                   WHERE R.FILENAME = T.FILENAME AND R.SN = T.SN AND R.IX = T.IX + 1 AND R.WORD LIKE %s",(word,nextword,))
    resultB = cursor.fetchall()[0]
    print "The number of nextword that follows word = %d" % (resultB)
   
# SECTION C
    # B/A will give you the P(sabah|bu)
    probability = int(resultB[0])/ int(resultA[0])
    print "P(%s / %s) = %s" % (resultB[0],resultA[0],probability)

    if probability==0:
       probability =1/int(resultA[0])
       print "The frequency of unseen word = %s" %(probability)
    print("\n")
    probability_list.append(probability)

#Print bigram probability of the input sentence  
print probability_list
bigram_prob=1
for i in range(0,len(probability_list)):
    #print probability_list[i]
    bigram_prob*=probability_list[i]
print "bigram probability of given sentences : %s" %(bigram_prob)

#disconnect from server
#db.close()
