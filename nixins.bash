#!/bin/bash
function nin(){
local	ARGS=$@
for ARG in "${ARGS}"
do
nix profile install nixpkgs#"${ARG}" --profile  /var/nix/nix-profiles/"${ARG}"
done
}


function nup(){
local	ARGS=$@
for ARG in "${ARGS}"
do
nix profile upgrade nixpkgs#"${ARG}" --profile  /var/nix/nix-profiles/"${ARG}"
done
}

function nil(){
local	ARGS=$@
for ARG in "${ARGS}"
do
nix profile list --profile  /var/nix/nix-profiles/"${ARG}"
done
}

function nir(){
local	ARGS=$@
for ARG in "${ARGS}"
do
nix profile remove "${ARG}" --profile  /var/nix/nix-profiles/"${ARG}"
done
}
