#!/usr/bin/env python3

import re
from sys import argv, exit
from os import popen

if len(argv) < 2:
    print("An argument must be given (raise, lower or toggle!)")
    exit(1)

action = argv[1]
volume = 0
sinks = popen("pactl list sinks").read()
for match in re.finditer(
    r"Sink #([0-9]+)",
    sinks
):
    sink = match.group(1)
    if action == "raise":
        popen("pactl set-sink-volume " + sink + " +5%").read()
    elif action == "lower":
        popen("pactl set-sink-volume " + sink + " -5%").read()
    elif action == "toggle":
        popen("pactl set-sink-mute " + sink + " toggle").read()
    elif action == "get":
        match = re.search(
            r"Volume: .*?([0-9]+)%.*?([0-9]+)%",
            sinks
        )
        left = int(match.group(1))
        right = int(match.group(2))
        volume = int((left + right) / 2)
    else:
        print("action must be raise, lower or toggle!")

if action == "get":
    print(str(volume) + "%")
