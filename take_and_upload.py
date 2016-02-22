"""Takes the pic and uploads it to twitter."""
import os
import subprocess
import sys

import keys

import tweepy

if len(sys.argv) == 4:
    if keys.API_KEY or keys.API_SECRET or keys.ACCESS_TOKEN or keys.ACCESS_TOKEN_SECRET:
        message = sys.argv[1]
        image = sys.argv[2]
        commit_id = sys.argv[3]

        if len(message) < 117:
            subprocess.call([os.path.expanduser("~/.gitshot/") + "imagesnap", "-q", image])
            auth = tweepy.OAuthHandler(keys.API_KEY, keys.API_SECRET)
            auth.set_access_token(keys.ACCESS_TOKEN, keys.ACCESS_TOKEN_SECRET)
            api = tweepy.API(auth)
            media = api.media_upload(image)
            status = api.update_status(media_ids=[media.media_id], status=message)
            print "Lookin good champ. Check out your beautiful face: https://twitter.com/" + status.author.screen_name + "/status/" + status.id_str
        else:
            print "Your commit message was too long to post to Twitter. Try being a little less verbose Shakespeare."
    else:
        print "You don't have Twitter keys set up. Edit your ~/.gitshot/keys.py!"
