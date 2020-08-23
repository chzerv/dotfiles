#!/usr/bin/env python3

import urllib.request
import re
import subprocess
import datetime
import xmltodict
from dateutil.parser import parse
from termcolor import cprint

def check_official_updates():
    process = subprocess.Popen(['checkupdates'], stdout=subprocess.PIPE)
    stdout = process.communicate()[0].decode('utf-8')

    if len(stdout.strip()) == 0:
        cprint("No updates found!", "red")
    else:
        cprint("Found " + stdout + "updates!\n", "green")
        choice = input("Would you like to update?(y/N)")
        if choice == 'n' or choice == 'N':
            cprint("Exiting..\n", "blue")
        elif choice == 'y':
            subprocess.call('sudo pacman -Syu', shell=True)
        else:
            return 0


def check_aur_updates():
    print("Updating AUR packages using yay.\n")
    subprocess.call('yay -Syua', shell=True)


def current_date():
    gen_date = datetime.datetime.now()
    cur_date = gen_date.strftime("%Y-%m-%d")
    return cur_date


def clean_html(raw_html):
    cleanr = re.compile('<.*?>')
    cleantext = re.sub(cleanr, '', raw_html)
    return cleantext


def update_alerts(last_update=False):
    url = 'https://www.archlinux.org/feeds/news/'
    file = urllib.request.urlopen(url)
    data = file.read()
    file.close()

    arch_news = xmltodict.parse(data)

    exit_code = 0

    for news in arch_news['rss']['channel']['item']:
        if not last_update and parse(news['pubDate']).strftime("%Y-%m-%d") >= current_date():
            exit_code = 1
            print('~' * 75)
            print("Title: ", news['title'])
            print("Date: ", news['pubDate'])
            print("Description: ", clean_html(news['description']))

    if exit_code == 0:
        cprint('No new Arch Linux news posts!', 'green')

    return exit_code


def menu():
    ans = True
    while ans:
        cprint("\n###########################################", 'blue')
        cprint("   ---- Arch Linux Update Script ----", 'red')
        cprint("###########################################", 'blue')
        print("""
        1) Fetch news.
        2) Update packages from the official repos.
        3) Update AUR packages
        4) Exit.
        """)
        ans = input("What would you like to do..?\n")
        if ans == "1":
            update_alerts()
        elif ans == "2":
            check_official_updates()
        elif ans == "3":
            check_aur_updates()
        elif ans == "4":
            cprint("\nExiting..", "blue")
            return 0
        else:
            print("Invalid choice!")



menu()
