if [ -f ~/.bash_profile ]; then
   source ~/.bash_profile
fi
if [ -f ~/.bashprofile ]; then
   source ~/.bashprofile
fi

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

export PATH="/opt/homebrew/bin:$PATH"

