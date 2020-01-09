#!/bin/bash
rm log.log
./run.sh > >(tee -a log.log) 2> >(tee -a log.log >&2)

