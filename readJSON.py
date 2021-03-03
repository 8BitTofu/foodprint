import json
import operator

data = []
recipeJSONPath = '/Users/tofuleung/Desktop/allrecipes.json'
categorySet = set()
categoryDict = {}

with open(recipeJSONPath) as f:
    for line in f:
        jsonData = (json.loads(line))

        for key in jsonData.keys():

        	recipeCategories = jsonData[key]["category"]
        	#print(recipeCategories)

        	for cat in recipeCategories:
        		# cat = str(cat)
        		#cat.encode("utf-8")
        		cat = repr(cat)

        		if cat not in categorySet:
        			categorySet.add(cat)
        			categoryDict[cat] = 1

        		else:
        			categoryDict[cat] += 1



with open('categories.txt','w') as f:


   for k, v in sorted(categoryDict.items(), key=lambda item: item[1], reverse = True):
   	f.write(k + ": " + str(v) + "\n")
