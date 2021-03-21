import requests
import bs4
import random

URL = 'https://stalker-game.fandom.com/ru/wiki/%D0%90%D0%BD%D0%B5%D0%BA%D0%B4%D0%BE%D1%82%D1%8B'


def get_html(url):
    r = requests.get(url)
    return r.text


def get_data(Chapter: str):
    html = get_html(URL)
    soup = bs4.BeautifulSoup(html, 'html.parser')
    jokes_main_class = soup.find(class_='mw-parser-output')
    jokes_poem = jokes_main_class.find_all(class_='poem')
    joke = None
    if Chapter == "ТЧ":
        joke = jokes_poem[random.randint(1, 34)]
    elif Chapter == "ЧН":
        joke = jokes_poem[random.randint(24, 65)]
    elif Chapter == "ЗП":
        joke = jokes_poem[random.randint(51, 114)]
    elif Chapter == "ВК":
        joke = jokes_poem[random.randint(51, 127)]
    return joke.get_text()
