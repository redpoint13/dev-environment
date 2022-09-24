# -*- coding: utf-8 -*-

from setuptools import setup, find_packages


with open('README.rst') as f:
    readme = f.read()

with open('LICENSE') as f:
    license = f.read()

setup(
    name='sample',
    version='0.1.0',
    description='DDR Send Gmail from Python',
    long_description=readme,
    author='Tony shouse',
    author_email='redpoint13@gmail.com',
    url='https://github.com/ddrcapital/gmail',
    license=license,
    packages=find_packages(exclude=('tests', 'docs'))
)

