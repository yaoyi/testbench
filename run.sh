#!/bin/sh

#bundle exec unicorn -p 9000
bundle exec unicorn -p 9000 -c config/unicorn-development.rb
