create_hook() {
    cat << 'EOF' > git-shot
echo "Smile! gitshot is taking your picture. Press CTRL+C fast if you're having a bad hair day."
COMMITID=$(git rev-parse HEAD)
COMMIT_MESSAGE=$(git log --format=%B -n 1 HEAD)
python ~/.gitshot/take_and_upload.py "$COMMIT_MESSAGE" ~/.gitshot/images/$COMMITID.jpg "$COMMITID"
EOF
    cat << 'EOF' > post-commit
GIT_DIR='.git'
cd ..
source hooks/git-shot
EOF
}

print_help() {
echo "
Gitshot - If cowsay can be a command line tool so can this.
Sets up a git repo to take pictures of your face and post them on Twitter.
Yep, that's really it.

Usage:
init - Initialize a repo with gitshot
status - Check if the repo is set up with gitshot
disable - Temporarily disable gitshot
enable - Enable a disabled gitshot hook
remove - Remove the gitshot hook
cleanup - Clean up the image cache
"
}

in_git_repo() {
    if [ -d "$GIT_DIR" ]
    then
        return 0
    else
        echo "This isn't a git repo! Can't gitshot here unfortunately. I know, you want everyone to see your face."
        return 1
    fi
}

GIT_DIR=.git/
HOOKS_DIR=.git/hooks/

case "$1" in
    cleanup)
        rm -rf ~/.gitshot/images/*.jpg
        echo "Image cache cleared. Don't worry, we also zipped them and sent them to the NSA."
        echo "(no we didnt that's a joke)"
    ;;
    status)
        if in_git_repo; then
            cd $HOOKS_DIR
            if [ -f git-shot ]
            then
                echo "gitshot is enabled for this repo!"
            elif [ -f git-shot.nofun ]
            then
                echo "gitshot is disabled for this repo :("
            elif [ ! -f git-shot ]
            then
                echo "gitshot hasn't been set up in this repo!"
            fi
        fi
    ;;
    disable)
        if in_git_repo; then
            cd $HOOKS_DIR
            mv git-shot git-shot.nofun
            echo "Hook disabled. We won't judge. Run \"gitshot enable\" to turn it back on."
        fi
    ;;
    enable)
        if in_git_repo; then
            cd $HOOKS_DIR
            mv git-shot.nofun git-shot
            echo "Hook re-enabled. Fun membership reinstated."
        fi
    ;;
    remove)
        if in_git_repo; then
            cd $HOOKS_DIR
            rm -f git-shot
            echo "Hook removed. Sorry you hate fun :("
        fi
    ;;
    init)
        if in_git_repo; then
            cd $HOOKS_DIR
            touch git-shot
            touch post-commit
            chmod +wx git-shot
            chmod +wx post-commit
            create_hook
            echo "Hook added. Take off that post-it note on your camera! Obama already knows what you look like."
        fi
    ;;
    *)
        print_help
    ;;
esac
