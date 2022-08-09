#!/bin/sh

c01=$'\e[1;37m'
c02=$'\e[1;32m'
c03=$'\e[1;35m'

f0=$'\e[1;30m'
f1=$'\e[1;37m'
f2=$'\e[0;37m'

dev='fnix'
kernel=`uname -rmo`
cpuspe="`sed -n '/model\ name/s/^.*:\ //p' /proc/cpuinfo | uniq` (x`nproc`)"
system=`sed 's/\s*[\(\\]\+.*$//' /etc/issue`

if [ -n "$DISPLAY" ]; then
  wmname=`echo i3`
else
  wmname="none"
fi

pkgnum=`pacman -Q | wc -l`

cat << EOF

${c01}▉▉  | ${f1}os ${f0}........... $f2$system
${c01}  ▉▉| ${f1}name ${f0}......... $f2$HOSTNAME
${c01}▉▉  | ${f1}packages ${f0}..... $f2$pkgnum
    | 
${c02}▉▉  | ${f1}wm ${f0}........... $f2$wmname
${c02}  ▉▉| ${f1}shell ${f0}........ $f2$SHELL
${c02}▉▉  | ${f1}terminal ${f0}..... $f2$TERM
    |
${c03}▉▉  | ${f1}dev ${f0}.......... $f2$dev
${c03}  ▉▉| ${f1}kernel ${f0}....... $f2$kernel
${c03}▉▉  | ${f1}processor ${f0}.... $f2$cpuspe

EOF
