# Setup hub function for git, if it is available; http://github.com/defunkt/hub
if [ "$commands[(I)hub]" ] && [ "$commands[(I)ruby]" ]; then
    # eval `hub alias -s zsh`
    function git(){
        if ! (( $+_has_working_hub  )); then
            hub --version &> /dev/null
            _has_working_hub=$(($? == 0))
        fi
        if (( $_has_working_hub )) ; then
            hub "$@"
        else
            command git "$@"
        fi
    }
fi

# Functions #################################################################

# https://github.com/dbb


# empty_gh [NAME_OF_REPO]
#
# Use this when creating a new repo from scratch.
empty_gh() { # [NAME_OF_REPO]
    repo = $1
    ghuser=$(  git config github.user )

    mkdir "$repo"
    cd "$repo"
    git init
    touch README
    git add README
    git commit -m 'Initial commit.'
    git remote add origin git@github.com:${ghuser}/${repo}.git
    git push -u origin master
}

# new_gh [DIRECTORY]
#
# Use this when you have a directory that is not yet set up for git.
# This function will add all non-hidden files to git.
new_gh() { # [DIRECTORY]
    cd "$1"
    ghuser=$( git config github.user )

    git init
    # add all non-dot files
    print '.*'"\n"'*~' >> .gitignore
    git add ^.*
    git commit -m 'Initial commit.'
    git remote add origin git@github.com:${ghuser}/${repo}.git
    git push -u origin master
}

# exist_gh [DIRECTORY]
#
# Use this when you have a git repo that's ready to go and you want to add it
# to your GitHub.
exist_gh() { # [DIRECTORY]
    cd "$1"
    name=$( git config user.name )
    ghuser=$( git config github.user )

    git remote add origin git@github.com:${ghuser}/${repo}.git
    git push -u origin master
}

# fork_gh [NAME_OF_REPO]
#
fork_gh() { # [NAME_OF_REPO]
    # https://github.com/themoken/canto-curses.git
    repofrom="$1"
	dirname="$2"
	# FIXME add if condition to check function variables.
    repo=$(echo "$repofrom" | cut -d "/" -f 5 | cut -d "." -f 1)
    name=$( git config user.name )
    ghuser=$( git config github.user )

    echo "git clone git@github.com:${ghuser}/${repo}.git $dirname"
    read YorN
    if [[ "$YorN" == "y" ]]; then
        git clone git@github.com:${ghuser}/${repo}.git "$dirname"
        echo "git remote add upstream '$repofrom'"
        read YorN2
        if [[ "$YorN2" == "y" ]]; then
            cd "$dirname"
            git remote add upstream "$repofrom"
            echo "fetching upstream"
            git fetch upstream
        else
            break
        fi
    else
        break
    fi
    # git merge upstream/master
}

# fetch & merge upstream
#
upstream_merge_gh() {
    git fetch upstream
    git merge upstream/master
}


# submodule_gh [REPO_URL] /path/to/dir
submodule_init_update_gh() { # []
    # git submodule add ${repo} ${DEST}
    git submodule init
    git submodule update
    git submodule foreach git submodule init
    git submodule foreach git submodule update
}

# Github Pages
# use "Admin" -> "GitHub Pages" -> "Automatic GitHub Page Generator"
pages_gh() {
    #cd $repo
    git fetch origin
    git checkout -b gh-pages origin/gh-pages
}


# End Functions #############################################################
