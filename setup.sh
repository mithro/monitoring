#! /bin/bash

if [ ! -d /config ]; then
  mkdir /config
fi

cd /config
if [ ! -d monitoring ]; then
  git clone git://github.com/mithro/monitoring.git
fi
cd monitoring
#git pull

for i in $(find . -name .git -prune -o -type d -print); do
  if [ ! -d /etc/$i ]; then
     mkdir -p /etc/$i
  fi
done

for i in $(find . -name .git -prune -o -type f -print); do
  ln -sfv $(realpath /config/monitoring/$i) $(realpath -s /etc/$i)
done

for i in *; do
  if [ -d $i ]; then
    /etc/init.d/$i restart
  fi
done

