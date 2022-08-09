## Polybar script by fnix
#
# ==

import requests

LASTFM_USER = "lastuser"
LASTFM_KEY = "lastkey"

if __name__ == "__main__":
    try:
        try:
            x = requests.get(f"https://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user={LASTFM_USER}&api_key={LASTFM_KEY}&limit=1&format=json").json()
            track = x["recenttracks"]["track"][0]
            if track["@attr"]["nowplaying"]:
                print(f"L   istening {track['name']} - {track['artist']['#text']}")
            else:
                print("No music playing now")
        except (KeyError, TypeError):
            print("No music playing now")
    except:
        print("No music playing now")