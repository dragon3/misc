#!/bin/bash
# $Id: backlog_svn_sync.sh 653 2008-08-25 13:12:27Z dragon3 $
#
# Script to svnsync "Backlog" project repository.
#

if [ $# -ne 2 ]; then
	echo "Usage: $0 [space key] [project key]"
	exit 1;
fi

SPACE_KEY=$1
PROJECT_KEY=$2

cwd=`pwd`
hook_revprop=${PROJECT_KEY}/hooks/pre-revprop-change

svnadmin create $PROJECT_KEY
echo '#!/bin/sh' > $hook_revprop
echo 'exit 0' >>  $hook_revprop
chmod +x $hook_revprop

svnsync init file://${cwd}/${PROJECT_KEY} https://${SPACE_KEY}.backlog.jp/svn/${PROJECT_KEY}
svnsync sync file://${cwd}/${PROJECT_KEY}

