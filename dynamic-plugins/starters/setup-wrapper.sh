#!/bin/bash

#============================================================================
# Script to replace the key elements in package.json.template with correct
# third-party plugin values and creates "package.json".
#
# Also creates "src/index.ts" from "src/index.ts.template" correctly replacing
# the third-party plugin
#
# author: sgahlot
#============================================================================


#------------------------------------------------------------------------------------------------------------------
# Main function
#
# Command line arguments expected:
#   -a <Author>
#   -w <Plugin Name without scope>
#   -s <Plugin short name>
#   -n <Plugin Name with scope>
#   -v <Plugin version>
#------------------------------------------------------------------------------------------------------------------
function process_cmd_args() {
  if [ $# -eq 0 ]; then
      USAGE
  fi

  local author
  local pluginNameWithoutScope
  local pluginShortName
  local pluginNameWithScope
  local pluginVersion
  local incorrectUsageMessage

  while getopts "a:A:w:W:s:S:n:N:v:V:" arg
  do
    case $arg in
      a|A)
        author="$OPTARG"
        ;;
      w|W)
        pluginNameWithoutScope="$OPTARG"
        ;;
      s|S)
        pluginShortName="$OPTARG"
        ;;
      n|N)
        pluginNameWithScope="$OPTARG"
        ;;
      v|V)
        pluginVersion="$OPTARG"
        ;;
      *)
        incorrectUsageMessage="** INVALID option: [$arg]"
        USAGE
        ;;
    esac
  done

  if [ -z "$author" ]; then
    printf "\n Error: missing author\n"
    USAGE
  elif [ -z "$pluginNameWithoutScope" ]; then
    printf "\n Error: missing Plugin Name without scope\n"
    USAGE
  elif [ -z "$pluginShortName" ]; then
    printf "\n Error: missing Plugin short name for description\n"
    USAGE
  elif [ -z "$pluginNameWithScope" ]; then
    printf "\n Error: missing Plugin Name with scope\n"
    USAGE
  elif [ -z "$pluginVersion" ]; then
    printf "\n Error: missing Plugin version\n"
    USAGE
  fi

  cat <<-GIVEN_DATA
  Using following values:
      author=$author
      pluginNameWithoutScope=$pluginNameWithoutScope
      pluginShortName=$pluginShortName
      pluginNameWithScope=$pluginNameWithScope
      pluginVersion=$pluginVersion
GIVEN_DATA

  sed -e "s;@THIRD_PARTY_PLUGIN_WITHOUT_SCOPE@;$pluginNameWithoutScope;" \
      -e "s;@THIRD_PARTY_PLUGIN_SHORT_NAME@;$pluginShortName;" \
      -e "s;@AUTHOR@;$author;" \
      -e "s;@THIRD_PARTY_PLUGIN_WITH_SCOPE@;$pluginNameWithScope;" \
      -e "s;@THIRD_PARTY_PLUGIN_VERSION@;$pluginVersion;" \
      package.json.template > package.json

  sed -e "s;@THIRD_PARTY_PLUGIN_WITH_SCOPE@;$pluginNameWithScope;" \
      src/index.ts.template > src/index.ts

  printf "\n -> package.json created with the above values...\n"

}

#------------------------------------------------------------------------------------------------------------------
# Displays usage and exits
#
# @param message to display before usage
#------------------------------------------------------------------------------------------------------------------
function USAGE() {
  cat <<- USAGE_INFO
    Usage: $0 args
    where args are:
        -a <Author>
        -w <Plugin Name without scope>
            Will be part of wrapper plugin name, e.g. adr, bazaar, awesome-plugin
            Must be lowercase and may contain hyphens and underscores
        -s <Plugin short name>
            will be part of wrapper plugin description, e.g. ADR, Bazaar, Awesome Plugin
        -n <Plugin Name with scope>
            Third-party plugin with scope, e.g. "@backstage/plugin-adr"
        -v <Plugin version>
            Third-party plugin version, e.g. "0.6.17-next.0"

    Examples:
      $0 -a someAuthor -w "adr" -s adr -n "@backstage/plugin-adr" -v "0.6.17-next.0"
      $0 -a someAuthor -w "adr-backend" -s adr -n "@backstage/plugin-adr-backend" -v "0.4.14-next.0"

    Exiting!!!

USAGE_INFO
    exit 1
}

process_cmd_args "$@"
