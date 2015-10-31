$:.unshift Dir.pwd
require 'factory_girl'
%w( spec/factories ).each do |path|
  Dir["#{path}/*.rb"].each {|file| require file }
end
require 'app'
