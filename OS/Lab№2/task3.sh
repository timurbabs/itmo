#!/usr/bin/env bash

ps -e -o pid,start_time --sort=start_time | tail -n 6 | head -n 1 | awk '{print $1}'
