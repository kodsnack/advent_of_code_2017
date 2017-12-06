#!/bin/sed -Enf

# Prime the pump on the first line
x
/^$/ s/^.*$/1/
x

# hold space is now <lineno>

# delete line with duplicate word (not necessary consecutive) to hold space
/\b(\w+)\b.*\b\1\b/d

# erase text in pattern space
#z

#Exchange the contents of the hold and pattern spaces.
x

# print the last line up to newline
$P

# Exchange the contents of the hold and pattern spaces.
#x


# Get the line number from hold space; add a zero
# if we're going to add a digit on the next line
#g
s/\n.*$//
/^9*$/ s/^/0/


# separate changing/unchanged digits with an x
s/.9*$/x&/


# keep changing digits in hold space
h
s/^.*x//
y/0123456789/1234567890/
x


# keep unchanged digits in pattern space
s/x.*$//


# compose the new number, remove the newline implicitly added by G
G
s/\n//
h
