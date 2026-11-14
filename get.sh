#!/bin/bash

if [[ "${0}" != "${BASH_SOURCE[0]}" ]]; then
	return 1 >/dev/null
fi

source shared.sh

function __Exec__() {
	local binf="$(cat bin.rust.ini)"
	cp -pf "${binf}" $(pwd)/
	if [[ "${?}" -eq 0 ]]; then
		MsgDone --color --msgot "Copy ok"
		return 0
	fi
	MsgError --color --msgot "Copy failed"
	return 1
}

function __Main__() {
	__Exec__
}

__Main__
exit 0
