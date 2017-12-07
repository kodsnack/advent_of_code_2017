import unittest
from day1 import solver

class MyTest(unittest.TestCase):
    def setUp(self):
        pass

    def test1(self):
        self.assertEqual(solver('1122'), 3)

    def test2(self):
	self.assertEqual(solver('1111'), 4)

    def test3(self):
        self.assertEqual(solver('1234'), 0)

    def test4(self):
	   self.assertEqual(solver('91212129'), 9)

    def test4(self):
        self.assertEqual(solver('912121239'), 9)

if __name__ == '__main__':
    unittest.main()
