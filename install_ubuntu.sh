#!/bin/sh
set -e

# Configure commands available
apt-get update\
&& apt-get upgrade -y\
&& apt-get install -y tini ttyd\
   nano\
   vim-tiny\
   iputils-ping\
   less\
   file\
   python3\
&& apt-get clean\
&& apt-get autoremove --purge\
&& apt-get purge -y apt\
&& rm -fr /etc/apt\
&& rm -fr /var/log/apt\
&& rm -fr /var/lib/apt\
&& rm -fr /var/lib/dpkg\
&& rm -fr /var/cache/apt\
&& rm -fr /var/log/*

# List of commands that are not wanted
rm /usr/bin/ping6

# Remove write permissions from key directories
chmod -R a-w /usr/bin /usr/sbin /sbin

# Configure user's default settings
mkdir -p /etc/skel

cat > /etc/skel/.profile << EOF
export EDITOR="nano"
export PS1="\w \$ "
EOF

# Generate a welcome message and a brief disclaimer
echo '
,-.___,-.
\_/  _\_/
  )>_O(        Ubuntu Linux 24.04
 { (_) }       cat /readme
  `-^-´ hjw
' > /etc/motd

cat > /readme << EOF
This Linux environment has minimal resources and lacks appropriate
security measures. It is not designed to handle personal or classified
data and exists for educational purposes only.
EOF

chmod 444 /readme
