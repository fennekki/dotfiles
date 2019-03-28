#!/usr/bin/env python3

import subprocess
import sys


def notify(summary, body=None, icon=None, urgency=None):
    params = ["notify-send", summary]

    if body is not None:
        params.append(body)
    if icon is not None:
        params.extend(("-i", icon))
    if urgency is not None:
        params.extend(("-i", urgency))

    subprocess.run(params)


def main(params):
    print(params)
    status = params["status"]

    notify(
        f"{status.title()}: {params['artist']} - {params['title']}",
        f"{params['album']} ({params['date']})")

if __name__ == "__main__":
    main({a: b for a, b in zip(sys.argv[1::2], sys.argv[2::2])})
