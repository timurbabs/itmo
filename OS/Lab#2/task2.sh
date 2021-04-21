#!/usr/bin/env bash

ps -e -o pid,command | grep "/sbin/" | awk '{print $1}' > ans2 
