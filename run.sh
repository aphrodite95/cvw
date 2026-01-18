#!/bin/bash
cd ~/project/cvw
source setup.sh 2>/dev/null
source eda_tools_setup 2>/dev/null
exec "$@"
