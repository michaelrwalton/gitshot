# Gitshot
Creates a `post-commit` hook to take a picture when you commit and upload it to a Twitter account. Capture all those precious moments before you push a bug to a production server or when you can't reproduce a customer's bug that you're pretty sure isn't your fault.

# Joining the fun
- Clone the repo
- Run ./install.sh
- Edit ~/.gitshot/keys.py with your Twitter API keys (https://apps.twitter.com/, make a new app and generate tokens for your own account)
- When you want to add the hook to a repo, run `gitshot init` and it'll make the hook for you!

# Where do I get Twitter Keys?
- Go to https://apps.twitter.com/ and log in with the account you want to post to
- Make a new app, call it anything
- Click on "Keys and Access Tokens"
- At the bottom, under *Your Access Token* create an access token for your account.
- Refresh the page and copy API Key, API Secret, Access Token, and Access Token Secret into ~/.gitshot/keys.py

# Usage
`gitshot init`
- Will initialize a post-commit hook in your current git repo to take pics when you commit

`gitshot remove`
- Will remove a post-commit hook from your current git repo

`gitshot cleanup`
- Will remove everything from the image cache `~/.gitshot/images`

There's other stuff too, just check the help dialog.

# Requirements
`gitshot` makes a few assumptions about your system

1. You have `git` installed locally (DUH)
1. You have `python` and `pip` installed locally
1. `/usr/local/bin` is in your PATH
1. You have an active webcam (currently only uses the first found camera on OSX).

# Example of the fun
[@hhcctech](https://twitter.com/hhcctech)

Yes, your commit messages are part of the tweet, so maybe only `gitshot` on open source projects/when you're sober.

# I want it added automatically to my new repos!
Look up git templates and copy the post-commit hook into a default one.

# imagesnap only works on OSX?
Yeah I'm looking into a better solution, stay tuned. This is only like v0.0.0.0.0.1