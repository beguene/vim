#!/usr/bin/env sh
function die()
{
    echo "${@}"
    exit 1
}
today=`date +%Y%m%d`
# Backup existing .vim stuff
echo "backing up current vim config...\n"
for i in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc; do
  if [[ ( -e $i ) || ( -h $i ) ]]; then
    echo "${i} has been renamed to ${i}.old.${today}"
    mv "${i}" "${i}.old.${today}" || die "Could not move ${i} to ${i}.old.${today}"
  fi
done

# Clone repo into vim
git clone https://github.com/carlhuda/janus.git $HOME/.vim \
  || die "Could not clone the repository to ${HOME}/.vim"

# Run rake inside .vim
cd $HOME/.vim || die "Could not go into the ${HOME}/.vim"
rake || die "Rake failed."
