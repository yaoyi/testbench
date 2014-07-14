# Bundler
require "rubygems"
require "bundler/setup"

require "sinatra"

get '/' do
    'Hello, nginx and unicorn!'
end
