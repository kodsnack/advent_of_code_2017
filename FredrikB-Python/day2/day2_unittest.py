import unittest
from day2 import solver

class MyTest(unittest.TestCase):
	def setUp(self):
		pass

	def test1(self):
		self.assertEqual(solver('test.txt'), 18)

if __name__ == '__main__':
	unittest.main()