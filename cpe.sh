#!/bin/bash

###############################################################################
# * Shell Style Guide Document: DAROSA_STYLE_GUIDE_FOR_BASH.md
# * Author    : ohmycode-cn(ohcode@163.com)
# * Date      : 2026-11-13
# * License   : MITi
# * File Type : compile project script
# * Language  : bash 5.0 plush
# * - - - - - : - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# * Usage     :
# *             bash cpe.sh [--param] <target> ...
###############################################################################

if [[ "${0}" != "${BASH_SOURCE[0]}" ]]; then
	echo -e "\033[31mFATAL\033[1;32m: \033[31mUsage -> bash cpe.sh [--param] <target> ...\033[0m"
	return 1 > /dev/null
fi

#source "shared.sh"

function InnerMain() {
	echo -e "RUN MAIN ..."
}

InnerMain
exit 0 # constant return exit exec symble 0
