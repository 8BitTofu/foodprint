from abc import ABC, abstractmethod
from bs4 import BeautifulSoup as bs
from urllib.parse import urlparse
import requests
import lxml

class abstract(ABC):
    def __init__(self, url):
        self.resp = requests.get(url)
        self.soup = bs(self.resp.text, 'lxml')

    @classmethod
    def host(cls):
        pass

    def title(self):
        pass

    def yields(self):
        pass

    # x days x hours x minutes
    def time(self):
        pass

    # in the form of a list
    def ingredients(self):
        pass

    # in the form of a list
    def instructions(self):
        pass

    # in the form of a dictionary
    def nutrients(self):
        pass

    # url
    def image(self):
        pass

    def category(self):
        pass

    def cuisine(self):
        pass

    def links(self):
        pass

    def isrecipe(self):
        pass