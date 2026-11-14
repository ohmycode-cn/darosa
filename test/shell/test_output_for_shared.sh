#!/bin/bash

if [[ "${0}" != "${BASH_SOURCE[0]}" ]]; then
	return 1 >/dev/null
fi

source "/data/data/com.termux/files/home/projects/engdevs/darosa/shared.sh"

function __TestHighlightColorString__() {
	echo -e "${BALCK}STRING${RESET}"
	echo -e "${RED}STRING${RESET}"
	echo -e "${GREEN}STRING${RESET}"
	echo -e "${YELLOW}STRING${RESET}"
	echo -e "${BLUE}STRING${RESET}"
	echo -e "${PURPLE}STRING${RESET}"
	echo -e "${CYAN}STRING${RESET}"
	echo -e "${WHITE}STRING${RESET}"	
}

function __TestOthersForShared__() {
	echo -e "${PURPLE}CURRENT TIME IS (NUIX POSIX UTC): ${ONCE_TIME}${RESET}"
}

function __TestMsgFunctionOutput__() {

	# Output normal strings
	MsgFatal --msgot "This is function: msgfatal output string"
	MsgError --msgot "This is function: msgerror output string"
	MsgAllow --msgot "This is function: msgallow output string"
	MsgInfo --msgot "This is function: msginfo output string"
	MsgWarn --msgot "This is function: msgwarn output string"
	MsgDone --msgot "This is function: msgdone output string"

	# Output highlight strings
	MsgFatal --color --msgot "This is function: msgfatal output string"
	MsgError --color --msgot "This is function: msgerror output string"
	MsgAllow --color --msgot "This is function: msgallow output string"
	MsgInfo --color --msgot "This is function: msginfo output string"
	MsgWarn --color --msgot "This is function: msgwarn output string"
	MsgDone --color --msgot "This is function: msgdone output string"

}

function __TestMain__() {
	__TestHighlightColorString__
	__TestOthersForShared__
	__TestMsgFunctionOutput__
}

__TestMain__

exit 0
