$:.unshift Dir.pwd

%w( app/models app/parsers ).each do |path|
  Dir["#{path}/*.rb"].each {|file| require file }
end

class App
  def initialize(options)
    puts 'Welcome to flight processor.'
  end
end
