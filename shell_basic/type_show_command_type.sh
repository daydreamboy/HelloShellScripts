#!/usr/bin/env bash

type ls # alias or external command
type cd # builtin command
type pod # external command
source ./type_dummy_exportee.sh
type pod # function
