require "rubygems"
require "sinatra"

log = File.new('logs/sinatra.log','a')
$stdout.reopen(log)
$stderr.reopen(log)

require File.expand_path "../myapp.rb", __FILE__
run Sinatra::Application 

