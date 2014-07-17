#!/bin/sh
#rackup -s Puma -p 9000
puma -p 9000 -C config/puma-development.rb
