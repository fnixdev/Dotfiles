## Slide Wallpapers by fnix
#
# ==

import os
import time

from apscheduler.schedulers.background import BackgroundScheduler

schedule = BackgroundScheduler()

def switch_wall():
    try:
        basepath = f"{os.path.expanduser('~')}/Wallpapers/*"
        os.system(f"feh --bg-max --bg-fill --no-fehbg --randomize {basepath} &")
    except Exception:
        pass

schedule.add_job(switch_wall, 'interval', minutes=1)
schedule.start()

while True:
    time.sleep(1)