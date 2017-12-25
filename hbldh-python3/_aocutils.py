#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
from urllib.request import build_opener

root_dir = os.path.dirname(os.path.abspath(__file__))


def ensure_data(day):
    day_input_file = os.path.join(root_dir, 'input_{0:02d}.txt'.format(day))
    if not os.path.exists(day_input_file):
        session_token = os.environ.get('AOC_SESSION_TOKEN')
        if session_token is None:
            raise ValueError("Must set AOC_SESSION_TOKEN environment variable!")
        url = 'https://adventofcode.com/2017/day/{0}/input'.format(day)
        opener = build_opener()
        opener.addheaders.append(('Cookie', 'session={0}'.format(session_token)))
        response = opener.open(url)
        with open(day_input_file, 'w') as f:
            f.write(response.read().decode("utf-8"))
