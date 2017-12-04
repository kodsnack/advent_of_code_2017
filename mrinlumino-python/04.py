#!/usr/bin/python
# -*- coding: utf-8 -*-


print ''
print '***************************************************************************************'
print '*                                                                                     *'
print '*                              Advent of code 2017 4/12                               *'
print '*                             @MrInlumino - Anders Rosen                              *'
print '*                                                                                     *'
print '***************************************************************************************'
print ''

# Open input data file and read it into a string
lines=[]
fo = open('04.data','r')
for line in fo:
    # Remove any character returns in the strings
    line = line.replace('\n','')
    # Replace all spaces with comma
    line = line.replace(' ', ',')
    # Add the string to the array
    lines.append(line)
fo.close()


# Define counter for valid pass phrases
noOfValidPassPhrases = 0

# Iterate over all the lines
for line in lines:
    # Split the strings into an array of words
    words = line.split(',')

    # Assume that the string is a valid pass phrase
    validPassPhrase = True
    
    # Iterate over all the words once for every word and see if the words found match
    word1Position = 0
    for word1 in words:
        word2Position = 0
        for word2 in words:
            # If the words are in different positions and match, then the pass phrase is invalid. 
            if (word1 == word2 and word1Position != word2Position):
                validPassPhrase = False
            word2Position += 1
        word1Position += 1
    
    # If the phrase was valid, then increase the counter. 
    if (validPassPhrase == True):
        noOfValidPassPhrases += 1




print('The solution to the first problem day 4: %d') % (noOfValidPassPhrases)



print ''
print '***************************************************************************************'
print ''



# Open input data file and read it into a string
lines=[]
fo = open('04.data','r')
for line in fo:
    # Remove any character returns in the strings
    line = line.replace('\n','')
    # Replace all spaces with comma
    line = line.replace(' ', ',')
    # Add the string to the array
    lines.append(line)
fo.close()

# A function that checks if two words are anagrams
def isAnagram(firstWord,secondWord):
    # Sort both words alphabetically 
    sortedWord1 = ''.join(sorted(firstWord))
    sortedWord2 = ''.join(sorted(secondWord))
    # If the sorted words are alike, then they are anagrams
    if (sortedWord1 == sortedWord2):
        return True
    else:
        return False
    

# Define counter for valid pass phrases
noOfValidPassPhrases = 0

# Iterate over all the lines
for line in lines:
    # Split the strings into an array of words
    words = line.split(',')

    # Assume that the string is a valid pass phrase
    validPassPhrase = True
    
    # Iterate over all the words once for every word and see if the words found match
    word1Position = 0
    for word1 in words:
        word2Position = 0
        for word2 in words:
            # If the words are in different positions and match or are anagrams, then the pass phrase is invalid. 
            if ((word1 == word2 or isAnagram(word1,word2)==True) and word1Position != word2Position):
                validPassPhrase = False
            word2Position += 1
        word1Position += 1
    
    # If the phrase was valid, then increase the counter. 
    if (validPassPhrase == True):
        noOfValidPassPhrases += 1


    

print('The solution to the second problem day 4: %d') % (noOfValidPassPhrases)