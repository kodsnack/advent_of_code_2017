#!/usr/bin/env python
import re

def solver(data):
	result = 0

	f = open(data, 'r')
	for line in f:
		data = [int(x) for x in line.split()]
		result += max(data) - min(data)

	return result

print solver('input.txt')