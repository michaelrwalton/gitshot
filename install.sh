required_files="imagesnap initshot.sh example_keys.py take_and_upload.py"
pip -q install tweepy
mkdir -p ~/.gitshot/images

for file in $required_files
do
    cp -f $file ~/.gitshot/
done

if [ ! -f ~/.gitshot/keys.py ]; then
    mv ~/.gitshot/example_keys.py ~/.gitshot/keys.py
fi

chmod +x ~/.gitshot/initshot.sh
chmod +x ~/.gitshot/imagesnap
ln -sf ~/.gitshot/initshot.sh /usr/local/bin/gitshot
echo "Almost done! Edit the following file with your twitter keys: "
echo "~/.gitshot/keys.py"
echo "When done, run \"gitshot\" in a git repo to create the hook"
echo "If you're just updating the script and already have keys, you can skip this"