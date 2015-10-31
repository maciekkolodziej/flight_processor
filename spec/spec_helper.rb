$:.unshift Dir.pwd
require 'factory_girl'
require 'app'

%w( spec/factories spec/models spec/features ).each do |path|
  Dir["#{path}/*.rb"].each {|file| require file }
end

RSpec.configure do |config|
  config.order = 'random'

  config.before(:suite) do
    clear_files
  end

  config.after(:all) do
    clear_files
  end
end

def clear_files
  %w( spec/tmp ).each do |path|
    FileUtils.rm_rf(Dir.glob("#{path}/*.*"))
  end
  FileUtils.rm_rf('errors.csv')
end
