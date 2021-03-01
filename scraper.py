from allrecipes import allrecipes
from urllib.parse import urlparse
import sys, os
import time
import json
import re

url_set = set() # for number 1
politeness = .3
recipe_set = set()
websites = ["https://allrecipes.com/"]

SCRAPERS = {allrecipes.host(): allrecipes}

def is_valid(url):
    parsed = urlparse(url)
    return not re.match(
        r".*\.(css|js|bmp|gif|jpe?g|ico"
        + r"|png|tiff?|mid|mp2|mp3|mp4"
        + r"|wav|avi|mov|mpeg|ram|m4v|mkv|ogg|ogv|pdf"
        + r"|ps|eps|tex|ppt|pptx|doc|docx|xls|xlsx|names"
        + r"|data|dat|exe|bz2|tar|msi|bin|7z|psd|dmg|iso"
        + r"|epub|dll|cnf|tgz|sha1"
        + r"|thmx|mso|arff|rtf|jar|csv"
        + r"|rm|smil|wmv|swf|wma|zip|rar|gz)$", parsed.path.lower())

def scrape(url, resp):
    global url_set

    url_set.add(url) # include unique urls
    new_links = []
    items = resp.links()
    for item in items:
        new_links.append(item)
    links = extract_next_links(url, new_links)
    return [link for link in links if is_valid(link)]

def extract_next_links(url, links):
    l = list()
    global url_set

    for link in links:
        try:
            pattern = r'(.*)\/.*\d+'
            similar_url_check = re.match(pattern, url)[1]
            comparison = re.match(pattern, new_link)[1]
            if similar_url_check != "" and similar_url_check == comparison:
                continue
        except:
            pass

        if(link not in url_set):
            l.append(link)
            url_set.add(link)
    return l

def get_host_name(url):
    parsed = urlparse(url)
    return re.sub(r'www\.', '', parsed.netloc)

def main():
    f = open("allrecipes2.json", 'w')
    global websites
    for website in websites:
        try:
            scraper_obj = SCRAPERS[get_host_name(website)](website)
            print(website)
        except:
            continue
        new_websites = scrape(website, scraper_obj)
        websites.extend(new_websites)
        if scraper_obj.isrecipe() == True:
            name = scraper_obj.title()
            if name == None:
                continue
            recipe_set.add(name)
            data = {}
            info = {}
            info['image'] = scraper_obj.image()
            info['yield'] = scraper_obj.yields()
            info['time'] = scraper_obj.time()
            info['ingredients'] = scraper_obj.ingredients()
            info['instructions'] = scraper_obj.instructions()
            info['nutrients'] = scraper_obj.nutrients()
            info['category'] = scraper_obj.category()
            info['cuisine'] = scraper_obj.cuisine()
            data[name] = info
            print(f"{name} -> {info}")
            print("\n", len(recipe_set), "\n")
            f.write(json.dumps(data))
            f.write('\n')
        time.sleep(politeness)
    f.close()

if __name__ == '__main__':
    main()