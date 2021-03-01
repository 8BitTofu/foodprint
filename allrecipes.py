from abstract import abstract
import json
import re

class allrecipes(abstract):
    def __init__(self, url):
        super().__init__(url)
        self.s = str(self.soup.head.script)
        self.info = json.loads(self.s[self.s.find('\n')+1:self.s.rfind('\n')])[1]

    @classmethod
    def host(cls):
        return "allrecipes.com"

    def title(self):
        try:
            return self.info['name']
        except:
            return None

    def yields(self):
        try:
            return self.info['recipeYield']
        except:
            return None

    def time(self):
        time = ''
        pattern = r'^P([0-9]+)DT([0-9]+)H([0-9]+)M$'
        try:
            obj = re.match(pattern, self.info['totalTime'])
            if int(obj[1]) != 0:
                time += f'{obj[1]} days '
            if int(obj[2]) != 0:
                time += f'{obj[2]} hours '
            if int(obj[3]) != 0:
                time += f'{obj[3]} minutes'
        except:
            return None
        return time

    def ingredients(self):
        try:
            return self.info['recipeIngredient']
        except:
            return None

    def instructions(self):
        l = []
        if self.info['recipeInstructions'] == None:
            return None
        for item in self.info['recipeInstructions']:
            if item['@type'] == 'HowToStep':
                l.append(item['text'])
        return l

    def nutrients(self):
        pattern = r'(\w+)(?:Content)'
        new_d = dict()
        if self.info['nutrition'] == None:
            return None
        for k, v in self.info['nutrition'].items():
            if k == '@type':
                continue
            if k == 'calories':
                new_d[k] = v
                continue
            obj = re.match(pattern, k)
            try:
                new_d[obj[1]] = v
            except:
                continue
        return new_d

    def image(self):
        try:
            return self.info['image']['url']
        except:
            None

    def category(self):
        try:
            return self.info['recipeCategory']
        except:
            return None

    def cuisine(self):
        try:
            return self.info['recipeCuisine']
        except:
            None

    def links(self):
        l = []
        for link in self.soup.find_all('a'):
            if not link.has_attr('href'):
                continue
            l.append(re.sub(r'#.*', '', link.get('href')))
        return l

    def isrecipe(self):
        try:
            return self.info["@type"] == "Recipe"
        except:
            return None




