#!/bin/sh

exec gvfs-set-attribute -t stringv "${1?}" metadata::emblems "${@:2}"
