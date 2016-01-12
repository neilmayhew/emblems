#!/bin/sh

exec gvfs-set-attribute -t unset "${1?}" metadata::emblems ''
