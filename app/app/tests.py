"""
sample test
"""

from django.test import SimpleTestCase

from app import calc


class CalcTests(SimpleTestCase):
    """ test the calc module """
    
    def test_add_numbers(self):
        """ Test adding numbers together """
        res = calc.add(3, 5)

        self.assertEquals(res, 8)

    def test_username_generator(self):
        """ tests the username generator """
        res = calc.generate_username("bilal", 23)

        self.assertEquals(res, "bilal23")