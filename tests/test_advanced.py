# -*- coding: utf-8 -*-

from .context import gmail

import unittest


class AdvancedTestSuite(unittest.TestCase):
    """Advanced test cases."""

    def test_thoughts(self):
        self.assertIsNone(gmail.hmm())


if __name__ == '__main__':
    unittest.main()
