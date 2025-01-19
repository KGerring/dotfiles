#!/usr/bin/env bash

#if [ -f ~/.bashrc ]; then
#   source ~/.bashrc
#fi

export SHELLCHECK_OPTS='--shell=bash'

#Add the following line to your ~/.bash_profile:
#[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
#
#[[ -r "/usr/local/etc/bash_completion.d/launchctl" ]] && . "/usr/local/etc/bash_completion.d/launchctl"
###  /usr/local/etc/bash_completion.d
#
#_completion_loader()
#{    . "/etc/bash_completion.d/$1.sh" >/dev/null 2>&1 && return 124}
#complete -D -F _completion_loader -o bashdefault -o default
#
#
#   ---------------------------
#       SHOPT
#  cdspell: fix spelling errors in `cd`
#   ---------------------------

shopt -s nocaseglob
shopt -s cdspell

alias wget='wget --no-check-certificate'
alias echo="/bin/echo"
alias youtubedl="youtube-dl --no-check-certificate "

export LC_COLLATE=C
export HOME="/Users/kristen"

export LDFLAGS="-L/opt/homebrew/opt/libarchive/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libarchive/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libarchive/lib/pkgconfig"

export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${XDG_STATE_HOME}"
export XDG_STATE_HOME="${HOME}/.state"
export SSH_DIRECTORY="${HOME}/.ssh"
export TZ="/usr/share/zoneinfo/US/Eastern"

#export HISTTIMEFORMAT='%F %T '
#export HISTCONTROL='ignoreboth' #HISTCONTROL=erasedups
#export HISTFILESIZE=2000000
#export HISTSIZE=10000
#export HISTIGNORE="?:??:ls:ll:ls -alh:pwd:clear:history"
# append to history, dont overwrite it
#shopt -s histappend
# attempt to save all lines of a multiple-line command in the same history entry
#shopt -s cmdhist
# save multi-line commands to the history with embedded newlines
#shopt -s lithist
# After each command, append to the history file and reread it
#export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$"\n"}history -a; history -c; history -r"

function tre() {
	tree -aC -I '.git|__pycache__|*.pyc' --dirsfirst "$@" | less -FRNX
}

if [ ! -x "$(which tree 2>/dev/null)" ]; then
	alias cheap-tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
fi

export CACHER_APIKEY="xyf6VvAxP9cKEnqd3SC1Wpf7"
export CACHER_APITOKEN="XEX123LPLsjXZEDgVz4Ec5ij"
export CACHERIO_KEY="xyf6VvAxP9cKEnqd3SC1Wpf7"
export CACHERIO_TOKEN="XEX123LPLsjXZEDgVz4Ec5ij"
export SKIP_CYTHON="1"
export PYTHONUSERBASE="/Users/kristen/local"
export LIBRARIES_API_KEY="e49c64d56761dca6fd0f15af5b3fe48d"

#   ---------------------------
#       ENVVARS
#  Export common config-names
#   ---------------------------

reset="\033[0m"
black="\033[0;30m"
blue="\033[0;34m"
cyan="\033[0;36m"
green="\033[0;32m"
orange="\033[0;33m"
purple="\033[0;35m"
red="\033[0;31m"
violet="\033[0;35m"
white="\033[0;37m"
yellow="\033[0;33m"

RESET="\033[0m"
BLACK="\033[1;30m"
BLUE="\033[1;34m"
CYAN="\033[1;36m"
GREEN="\033[1;32m"
ORANGE="\033[1;33m"
PURPLE="\033[1;35m"
RED="\033[1;31m"
VIOLET="\033[1;35m"
WHITE="\033[1;37m"
YELLOW="\033[1;33m"

export MANPATH="/opt/homebrew/opt/coreutils/libexec/gnuman:/opt/homebrew/opt/findutils/libexec/gnuman:$MANPATH"
export RSYNC_LOGFILE="${HOME}/.rsync.log"
export GITIGNORE_GLOBAL="${HOME}/.gitignore_global"
export ANSIBLE_CONFIG="${HOME}/.ansible/ansible.cfg"

export PY_DEVTOOLS_HIGHLIGHT="True"
# export PYTHONHUNTERCONFIG="stdlib=False,force_colors=True"

export MACHINE_GITHUB_API_TOKEN="f3e021ff0242261ce0b95a62fd7b1baae237f27e"
export GITHUB_TOKEN_NEW="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"
export GITHUB_HOMEBREW_API_TOKEN="7ba7ca5bfae35bd8a9e8453df1d794d169eb17f8"
export GITHUB_TOKEN="b6250f824ec3e4fa583b196d574a6a471d41b018"

#export PYTEST_DISABLE_PLUGIN_AUTOLOAD="1"

#   ---------------------------
#       RECENTS
#  New things
#   ---------------------------

function listssh() {
	echo -e "ssh-keygen -lv -f ~/.ssh/known_hosts"
	ssh-keygen -lv -f ~/.ssh/known_hosts
}

function syncdesktop() {

	printf "${yellow} #TODO: get hostnames from list? ${reset}\n"

	local FOLDER
	FOLDER=${2:-repos}

	if [[ -n $1 ]]; then
		printf "rsync ${cyan} ${PWD}/$1 ${reset} to ${violet} /repos/$1 ${reset}\n"
		rsync $1 -azv --log-file="${RSYNC_LOGFILE}" --exclude='.git*' \
			--exclude-from="${GITIGNORE_GLOBAL}" kristen@kristen.local:~/${FOLDER}/
		unset FOLDER
	fi
}

function syncrepo() {
	### check if $1 exists
	### run --dry-run
	printf "${yellow} #TODO: get hostnames from list? ${reset}\n"

	local REMOTE
	REMOTE=${2:-pycharmpi}

	if [[ -n $1 ]]; then
		printf "rsync ${cyan} ${PWD}/$1 ${reset} to ${violet} /home/pi/repos/$1 ${reset}\n"
		echo "logfile --log-file=${RSYNC_LOGFILE} --exclude='.git*' --exclude-from=${GITIGNORE_GLOBAL}"
		echo "syncing with pi@${REMOTE}.local"

		rsync $1 -azv --log-file="${RSYNC_LOGFILE}" --exclude='.git*' \
			--exclude-from="${GITIGNORE_GLOBAL}" pi@${REMOTE}.local:~/repos/
		unset REMOTE
	fi
}

function syncfile() {
	printf "${yellow} #TODO: get hostnames from list? ${reset}\n"

	local REMOTE
	REMOTE=${2:-pycharmpi}

	if [ -f $1 ]; then
		printf "rsync ${cyan} $1 ${reset} to ${violet} /home/pi/Documents/$1 ${reset}\n"
		rsync $1 -azv --log-file="${HOME}/.rsync.log" pi@${REMOTE}.local:/home/pi/Documents/
		unset REMOTE
	fi
}

function ldir() {

	if [[ -n $1 ]]; then
		ls -F -G -l $1 | grep '/$'

	elif [[ -z $1 ]]; then
		ls -F -G -l ${1:PWD} | grep /$
	fi
}

#   ---------------------------
#       ENVVARS
#  Export common config-names
#   ---------------------------

export BASH_SILENCE_DEPRECATION_WARNING=1
#export XML_CATALOG_FILES="/etc/xml/catalog/catalog.xml"
#export SGML_CATALOG_FILES=""
#export RNG_SCHEMA_FOLDER="/Users/kristen/.xmlcatalog/rngschema"

export YOUTRACK_URL="https://kgerring.myjetbrains.com/youtrack"
export YOUTRACK_LOGIN="kgerring@gmail.com"
export YOUTRACK_PASSWORD="Ekalb43931"
export YOUTRACK_URL_DUP="https://kgerring.myjetbrains.com/"
export YOUTRACK_TOKEN="perm:cm9vdA==.NDktMA==.852LDmS2z6RfSSrG3ZU7pqB1UJ3gkJ"

#export WEBHOOK_VERIFY_TOKEN="ac5613a95c50733c63c72a910edffd7dc1e22376c6dd7d1b"
#export DROPBOX_KEY="c0bbjbn70p05obd"
#export DROPBOX_SECRET="uhg1nuxlb92vahf"
#export DROPBOX_TOKEN="Th5hvwVfeSAAAAAAAAAAotrzpY8Qfn2Gy5D10MuG6tG42WrKl-YDsj6Djz140LQ0"
#export DROPBOX_TOKEN = 'Th5hvwVfeSAAAAAAAAAAotrzpY8Qfn2Gy5D10MuG6tG42WrKl-YDsj6Djz140LQ0'

export SHELL="/opt/homebrew/bin/bash"
#export PYLINT_CONFIG="${XDG_CONFIG_HOME}/pylint"
#export PICKLESHARE="${XDG_CACHE_HOME}/.pickleshare/cache"
#export PROJECTDIR="${HOME}/PycharmProjects"
#export PYLINTHOME="${HOME}/.pylint"

export CHARM="/usr/local/bin/charm"
export DOWNLOADS="${HOME}/Downloads"
export EDITOR="/usr/bin/nano"
export GIT_EDITOR="nano"
export GIT_PYTHON_TRACE="full"

#export GITHUBTOKEN="8c922b93ca8678aed4ed473d67b30af9d3a5cbbf"
export HB="7ba7ca5bfae35bd8a9e8453df1d794d169eb17f8"
export HOMEBREW_DEV_CMD_RUN="True"
export HOMEBREW_INSTALL_CLEANUP="True"
export HOMEBREW_NO_AUTO_UPDATE="1"

export PYTHONBREAKPOINT="ipdb.set_trace"
#export PYTHONDEBUG="true"
export PYTHONDONTWRITEBYTECODE="true"
#export PYTHONOPTIMIZE="true"
export PYTHONPYCACHEPREFIX="${HOME}/CACHE"
#export IPYTHON_STARTUP="${HOME}/.ipython/profile_default/startup"
#export PYTHONSTARTUP="${HOME}/.ipython/profile_mycluster/startup/_ipython_start.py"

export PATH="/opt/homebrew/opt/libarchive/bin:$PATH"
export PATH="/opt/homebrew/anaconda3/bin:$PATH"
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:$PATH"
export PATH="/Library/Developer/CommandLineTools/usr/bin:$PATH"
export PATH="/Applications/PyCharm.app/Contents/MacOS:$PATH"
#export PATH="/opt/homebrew/opt/libarchive/bin:$PATH"
#export PATH="/opt/homebrew/opt/libarchive/bin:$PATH"

#   ---------------------------
#     ALIASES
#   ---------------------------

alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl '
alias finderShowHidden='defaults write com.apple.finder ShowAllFiles TRUE'
alias finderHideHidden='defaults write com.apple.finder ShowAllFiles FALSE'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias listDomains='defaults domains | sed s/","/""/g| xargs -n 1'
alias less='less -FSRXc'
alias gfind='find'
alias netCons='lsof -i' # netCons:      Show all open TCP/IP sockets
#: alias flushDNS='dscacheutil -flushcache'          # flushDNS:     Flush out the DNS Cache
#: alias lsock='sudo /usr/sbin/lsof -i -P'           # lsock:        Display open sockets
#: alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP' # lsockU:       Display only open UDP sockets
#: alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP' # lsockT:       Display only open TCP sockets
#alias ipInfo0='ipconfig getpacket en0'            # ipInfo0:      Get info on connections for en0
#alias my-ip='ipconfig getifaddr en0'
#alias ipInfo1='ipconfig getpacket en1'       # ipInfo1:      Get info on connections for en1
#: alias openPorts='sudo lsof -i | grep LISTEN' # openPorts:    All listening connections
#: alias showBlocked='sudo ipfw list'           # showBlocked:  All ipfw rules inc/ blocked IPs

#alias namefind="find . -name " # namefind:    Quickly search for file
alias top='top -o cpu'
#alias memorySummary='top -l 1 | head -8'
alias map="xargs -n1"

alias tstat='stat  -t "%Y-%M-%dT%H:%M:%S"'
alias grep="grep --colour=always"

alias list_files='echo *'

alias ll="ls -aFGltr --color=always"
alias lsd='ls -lF --color | grep --color=never '\''^d'\'''

alias pplist='plutil -p'
alias dscleanup="find . -type f -name '*.DS_Store' -ls -delete"

alias isort_force="isort --force-single-line-imports --keep-direct-and-as --no-sections --atomic"

### open in Sublime Text
function sub() {
	if [ -f $1 ]; then
		printf "${orange} opening ${reset} ${blue} '$@' ${reset}\n"
		open "$@" -a "Sublime Text"
	fi
}

#/Users/kristen/bash_scripts/new/bas.sh

# Determine size of a file or total size of a directory
function fs() {
	if du -b /dev/null >/dev/null 2>&1; then
		local arg=-sbh
	else
		local arg=-sh
	fi

	if [[ -n $@ ]]; then
		du $arg -- "$@"
	else
		du $arg .[^.]* ./*
	fi
}

function brew_verbose() {
	echo "The following variables are set to:"
	echo HOMEBREW_VERBOSE "${HOMEBREW_VERBOSE}"
	echo HOMEBREW_DEVELOPER "${HOMEBREW_DEVELOPER}"
	echo HOMEBREW_DEBUG "${HOMEBREW_DEBUG}"
	echo "what verbosity to set?"
	echo "[ -v <verbose> |--d <developer> |-b <debug> |-q <silent> ]"
	read level
	sleep 1
	echo
	case $level in
	v)
		echo "setting HOMEBREW_VERBOSE=1"
		export HOMEBREW_VERBOSE="True"
		;;
	d)
		echo "setting HOMEBREW_DEVELOPER"
		export HOMEBREW_DEVELOPER="1"
		;;
	b)
		echo "setting HOMEBREW_DEBUG"
		export HOMEBREW_DEBUG="True"
		;;
	q)
		echo "unsetting all so silent"
		unset HOMEBREW_DEBUG
		unset HOMEBREW_DEVELOPER
		unset HOMEBREW_VERBOSE
		;;
	*)
		echo "default silent:"
		unset HOMEBREW_DEBUG
		unset HOMEBREW_DEVELOPER
		unset HOMEBREW_VERBOSE
		;;
	esac
}

# if [[ -n "$@" ]]; then

function extract() {
	if [ -f $1 ]; then
		case $1 in
		*.tar.bz2) tar xjf $1 ;;
		*.tar.gz) tar xzf $1 ;;
		*.bz2) bunzip2 $1 ;;
		*.rar) unrar e $1 ;;
		*.gz) gunzip $1 ;;
		*.tar) tar xf $1 ;;
		*.tbz2) tar xjf $1 ;;
		*.tgz) tar xzf $1 ;;
		*.zip) unzip $1 ;;
		*.Z) uncompress $1 ;;
		*.7z) 7z x $1 ;;
		*) echo "'$1' cannot be extracted via extract()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

#   showa: to remind yourself of an
#   ------------------------------------------------------------

function showa() { /usr/bin/grep --color=always -i -a1 $@ ~/Library/init/bash/aliases.bash | grep -v '^\s*$' | less -FSRXc; }

function uniq_path() {
	if [ -n "$PATH" ]; then
		old_PATH=$PATH:
		PATH=
		while [ -n "$old_PATH" ]; do
			x=${old_PATH%%:*} # the first remaining entry
			case $PATH: in
			*:"$x":*) ;;        # already there
			*) PATH=$PATH:$x ;; # not there yet
			esac
			old_PATH=${old_PATH#*:}
		done
		PATH=${PATH#:}
		unset old_PATH x
	fi
}

#printf "about to run ${violet} dircolors line 408 ${reset}\n"

d=.dircolors
test -r $d && eval "$(dircolors $d)"

#pintf "about to run ${violet} dircolors run! ${reset}line 412\n"
alias config='/usr/bin/git --git-dir=/Users/kristen/.cfg/ --work-tree=/Users/kristen'


export CHARM="/usr/local/bin/charm"
#  Added by Toolbox App
export PATH="$PATH:/Users/kristen/Library/Application Support/JetBrains/Toolbox/scripts"



printf "about to run ${violet} ~/bash_post.sh ${reset}\n"
. ~/.bash_post.sh
printf "${blue} post load? ${reset}\n"

## >>> conda initialize >>>
## !! Contents within this block are managed by 'conda init' !!
#
#printf "attempting ${purple} conda initialize ${reset}\n"
#__conda_setup="$('/opt/homebrew/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
#
#if [ $? -eq 0 ]; then
#	printf "running eval on ${green} __conda_setup ${reset}\n"
#    eval "$__conda_setup"
#
#else
#    if [ -f "/opt/homebrew/anaconda3/etc/profile.d/conda.sh" ]; then
#    	printf "sourcing ${purple} /opt/homebrew/anaconda3/etc/profile.d/conda.sh ${reset}\n"
#        . "/opt/homebrew/anaconda3/etc/profile.d/conda.sh"
#    else
#    	printf "adding ${blue} /opt/homebrew/anaconda3/bin ${reset} to start of ${orange} PATH ${reset}\n"
#        export PATH="/opt/homebrew/anaconda3/bin:$PATH"
#    fi
#fi
#
#printf "Done! unsetting ${green} __conda_setup ${reset}\n"
#unset __conda_setup
## <<< conda initialize <<<

eval $(dircolors ~/.dircolors)


