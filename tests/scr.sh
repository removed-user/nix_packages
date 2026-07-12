#!/bin/bash
function updpath() {
local TMPATH="$(echo $PATH | sed 's#:# #g')"
# read -a TMPATH <<<
printf '%s\n'  ${TMPATH} | awk '!visited[$0]++'
}
updpath
