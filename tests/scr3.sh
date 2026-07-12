function updpath() {
	function check_bin-path() {
		if [[ $(echo "$NIX_LINK/bin") != /bin ]] 
then
	local NL="$NIX_LINK"/bin &&  echo NL\="$NL"
fi
		if [[ $(echo "$NUIX_LINK/bin") != /bin ]]
then
	local NXL="$NUIX_LINK/bin" && echo NXL\="$NXL"
fi
}
check_bin-path
# local TMPATH="$(echo "$NIX_LINK/bin:$NUIX_LINK/bin:$PATH" | sed 's#:# #g')"
# echo $TMPATH
# printf '%s\n'  ${TMPATH} | awk '!visited[$0]++'
}
updpath
