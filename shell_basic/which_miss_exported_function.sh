#!/usr/bin/env bash

which pod
source ./which_dummy_exportee.sh
which pod # Note: now pod is an actual function, but which still display the pod command
# pod install/update
type pod
