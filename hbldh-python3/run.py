#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import importlib


def main(which_days):
    for day in which_days:
        try:
            day_module = importlib.import_module(
                'day{0:02d}'.format(day), 'AOC2017')
            print("Solutions to Day {0:02d}\n-------------------".format(day))
            day_module.main()
            print('')
        except:
            print("Day {0:02d} failed to run!\n".format(day))


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser("Advent of Code AOC2017 - hbldh")
    parser.add_argument(
        'day', nargs='*', default=None, help="Run only specific day's problem")
    parser.add_argument(
        '--token', type=str, default=None,
        help="AoC session token. Needed to download data automatically.")
    args = parser.parse_args()

    if args.token:
        os.environ["AOC_SESSION_TOKEN"] = args.token

    if args.day:
        days = map(int, args.day)
    else:
        days = range(1, 26)

    main(days)
