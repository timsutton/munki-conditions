#!/bin/sh

# Pull the Computer GUID out of the CrashPlan identity file, store as 'crashplan_computer_guid'

DEFAULTS=/usr/bin/defaults
CPP_IDENTITY_FILE=/Library/Application\ Support/CrashPlan/.identity

if [ -e "$CPP_IDENTITY_FILE" ]; then
	MUNKI_DIR=$("$DEFAULTS" read /Library/Preferences/ManagedInstalls ManagedInstallDir)
	if [ "$MUNKI_DIR" = "" ]; then
		echo "No Managed Installs directory could be read, exiting.."
		exit 1
	fi
	COND_DOMAIN="$MUNKI_DIR/ConditionalItems"
    GUID=$(/usr/bin/awk -F= '/guid/ {print $2}' "$CPP_IDENTITY_FILE")

    "$DEFAULTS" write "$COND_DOMAIN" crashplan_computer_guid -string "$GUID"
fi
