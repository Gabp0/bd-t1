#!/bin/bash
sed 's/.$//' "$1" > "$1.tmp"
mv "$1.tmp" "$1"