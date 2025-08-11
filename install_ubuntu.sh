#!/bin/sh
set -e

# Install script for the contents of the linux-cli

# Configure commands available
apt-get update\
&& apt-get upgrade -y\
&& apt-get install -y tini ttyd\
 nano\
 vim-tiny\
 iputils-ping\
 tmux\
 screen\
 tree\
 wget\
 less\
 file\
 python3\
 python3.12-venv \
&& rm -f /etc/pam.d/login \
&& echo "" > /etc/legal \
&& apt-get clean \
&& apt-get autoremove --purge \
&& rm -fr /etc/apt \
&& rm -fr /var/log/apt \
&& rm -fr /var/lib/apt \
&& rm -fr /var/lib/dpkg \
&& rm -fr /var/cache/apt \
&& rm -fr /var/log/*

# List of commands that are not wanted
rm /usr/bin/ping6 \
&& rm /usr/bin/unminimize

# Remove write permissions from key directories
chmod -R a-w /usr/bin /usr/sbin /sbin

# Configure user's default settings
rm /etc/skel/.profile
ln -s my-work/.profile /etc/skel/.profile

# Generate a minimum pam.d/login file to correctly show motd message above
cat > /etc/pam.d/login << 'EOF'
auth       required     pam_securetty.so
auth       requisite    pam_nologin.so
auth       include      common-auth
account    include      common-account
session    required     pam_env.so readenv=1
session    required     pam_env.so readenv=1 envfile=/etc/default/locale
session    required     pam_motd.so motd=/etc/motd
session    include      common-session
session    optional     pam_mail.so standard
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
