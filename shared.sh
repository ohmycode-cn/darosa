#!/bin/bash

###############################################################################
# * Shell Style Guide Document: DAROSA_STYLE_GUIDE_FOR_BASH.md
# * Author    : ohmycode-cn(ohcode@163.com)
# * Date      : 2026-11-13
# * License   : MIT
# * File Type : shared functions resource script
# * Language  : bash 5.0 plush
# * - - - - - : - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# * Usage     :
# *             Target file include: source "shared.sh", you can append
# *           #shellcheck disable SC=NUMBER suppress warning !
###############################################################################

__ANSI__="\x1b"
__FONT__="[0;"
__CHAR__="m"
readonly __ANSI__
readonly __FONT__
readonly __CHAR__

RESET="${__ANSI__}${__FONT__}0${__CHAR__}"   # HIGHLIGHT COLOR: RESET
BLACK="${__ANSI__}${__FONT__}30${__CHAR__}"  # HIGHLIGHT COLOR: BLACK
RED="${__ANSI__}${__FONT__}31${__CHAR__}"    # HIGHLIGHT COLOR: RED
GREEN="${__ANSI__}${__FONT__}32${__CHAR__}"  # HIGHLIGHT COLOR: GREEN
YELLOW="${__ANSI__}${__FONT__}33${__CHAR__}" # HIGHLIGHT COLOR: YELLOW
BLUE="${__ANSI__}${__FONT__}34${__CHAR__}"   # HIGHLIGHT COLOR: BLUE
PURPLE="${__ANSI__}${__FONT__}35${__CHAR__}" # HIGHLIGHT COLOR: PURPLE
CYAN="${__ANSI__}${__FONT__}36${__CHAR__}"   # HIGHLIGHT COLOR: CYAN
WHITE="${__ANSI__}${__FONT__}37${__CHAR__}"  # HIGHLIGHT COLOR: WHITE

__SEMI_RED__="${RED}:${RESET}"
__SEMI__="${WHITE}:${RESET}"
readonly __SEMI_RED__
readonly __SEMI__

__FATAL__="${RED}FATAL${RESET}"
__ERROR__="${RED}ERROR${RESET}"
__ALLOW__="${GREEN}ALLOW${RESET}"
__INFO__="${GREEN}INFO${RESET}"
__WARN__="${YELLOW}WARN${RESET}"
__DONE__="${GREEN}DONE${RESET}"
readonly __FATAL__
readonly __ERROR__
readonly __ALLOW__
readonly __INFO__
readonly __WARN__
readonly __DONE__


ONCE_TIME="$(date +%F-%H-%M-%S-%3N)"

#######################################
# Print the current timestamp, optionally rendered in ANSI color.
# Globals:
#   RED
#   BLUE
#   RESET
# Arguments:
#   $1: Optional. Pass "True" to wrap the timestamp in color escapes.
# Outputs:
#   Writes "[YYYY-MM-DD-HH-MM-SS-mmm]" to STDOUT.
# Returns:
#   Always returns 0.
#######################################
function NowTime() {

	local times="$(date +%F-%H-%M-%S-%3N)"
	local color="${1}"

	if [[ ! -z "${color}" && "True" == "${color}" ]]; then
		echo -e "${RED}[${BLUE}${times}${RED}]${RESET}"
		return 0
	fi

	echo -e "[${times}]"
	return 0
}

#######################################
# Print a fatal-level log message to STDOUT.
# Globals:
#   __FATAL__
#   __SEMI_RED__
#   RED
#   RESET
# Arguments:
#   --color: Optional. Enable colored timestamp rendering.
#   --msgot: Required. The message body to print.
# Outputs:
#   Writes "<timestamp> FATAL: <msgot>" to STDOUT.
# Returns:
#   Always returns 0.
#######################################
function MsgFatal() {

	local color="False"
	local msgot=""

	while [[ $# -gt 0 ]]; do
		case "${1}" in
			--color) color="True"; shift;;
			--msgot) msgot="${2}"; shift 2;;
			*) shift;;
		esac
	done

	echo -e "$(NowTime ${color}) ${__FATAL__}${__SEMI_RED__} ${RED}${msgot}${RESET}"
}

#######################################
# Print an error-level log message to STDOUT.
# Globals:
#   __ERROR__
#   __SEMI__
#   RED
#   RESET
# Arguments:
#   --color: Optional. Enable colored timestamp rendering.
#   --msgot: Required. The message body to print.
# Outputs:
#   Writes "<timestamp> ERROR: <msgot>" to STDOUT.
# Returns:
#   Always returns 0.
#######################################
function MsgError() {

	local color="False"
	local msgot=""

	while [[ $# -gt 0 ]]; do
		case "${1}" in
			--color) color="True"; shift;;
			--msgot) msgot="${2}"; shift 2;;
			*) shift;;
		esac
	done

	echo -e "$(NowTime ${color}) ${__ERROR__}${__SEMI__} ${RED}${msgot}${RESET}"
}

#######################################
# Print an allow-level log message to STDOUT.
# Globals:
#   __ALLOW__
#   __SEMI__
#   GREEN
#   RESET
# Arguments:
#   --color: Optional. Enable colored timestamp rendering.
#   --msgot: Required. The message body to print.
# Outputs:
#   Writes "<timestamp> ALLOW: <msgot>" to STDOUT.
# Returns:
#   Always returns 0.
#######################################
function MsgAllow() {

	local color="False"
	local msgot=""

	while [[ $# -gt 0 ]]; do
		case "${1}" in
			--color) color="True"; shift;;
			--msgot) msgot="${2}"; shift 2;;
			*) shift;;
		esac
	done

	echo -e "$(NowTime ${color}) ${__ALLOW__}${__SEMI__} ${GREEN}${msgot}${RESET}"
}

#######################################
# Print an info-level log message to STDOUT.
# Globals:
#   __INFO__
#   __SEMI__
#   CYAN
#   RESET
# Arguments:
#   --color: Optional. Enable colored timestamp rendering.
#   --msgot: Required. The message body to print.
# Outputs:
#   Writes "<timestamp> INFO: <msgot>" to STDOUT.
# Returns:
#   Always returns 0.
#######################################
function MsgInfo() {

	local color="False"
	local msgot=""

	while [[ $# -gt 0 ]]; do
		case "${1}" in
			--color) color="True"; shift;;
			--msgot) msgot="${2}"; shift 2;;
			*) shift;;
		esac
	done

	echo -e "$(NowTime ${color}) ${__INFO__}${__SEMI__} ${CYAN}${msgot}${RESET}"
}

#######################################
# Print a warning-level log message to STDOUT.
# Globals:
#   __WARN__
#   __SEMI__
#   YELLOW
#   RESET
# Arguments:
#   --color: Optional. Enable colored timestamp rendering.
#   --msgot: Required. The message body to print.
# Outputs:
#   Writes "<timestamp> WARN: <msgot>" to STDOUT.
# Returns:
#   Always returns 0.
#######################################
function MsgWarn() {

	local color="False"
	local msgot=""

	while [[ $# -gt 0 ]]; do
		case "${1}" in
			--color) color="True"; shift;;
			--msgot) msgot="${2}"; shift 2;;
			*) shift;;
		esac
	done

	echo -e "$(NowTime ${color}) ${__WARN__}${__SEMI__} ${YELLOW}${msgot}${RESET}"
}

#######################################
# Print a done-level log message to STDOUT.
# Globals:
#   __DONE__
#   __SEMI__
#   GREEN
#   RESET
# Arguments:
#   --color: Optional. Enable colored timestamp rendering.
#   --msgot: Required. The message body to print.
# Outputs:
#   Writes "<timestamp> DONE: <msgot>" to STDOUT.
# Returns:
#   Always returns 0.
#######################################
function MsgDone() {

	local color="False"
	local msgot=""

	while [[ $# -gt 0 ]]; do
		case "${1}" in
			--color) color="True"; shift;;
			--msgot) msgot="${2}"; shift 2;;
			*) shift;;
		esac
	done

	echo -e "$(NowTime ${color}) ${__DONE__}${__SEMI__} ${GREEN}${msgot}${RESET}"
}

