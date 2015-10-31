$:.unshift Dir.pwd

require 'logger'
require 'app/parsers/parser'
require 'csv'
require 'virtus'
require 'active_model'

%w( app/loggers app/models app/parsers ).each do |path|
  Dir["#{path}/*.rb"].each {|file| require file }
end

class App
  attr_reader :options, :input_file_path, :output_file_path, :parser

  def initialize(options)
    @options = options
    @input_file_path = options.fetch('input_file')
    @output_file_path = options.fetch('output_file')
    $quiet = options.fetch('quiet')

    puts 'Welcome to flight processor.' unless $quiet

    check_input_file!
    process
  end

  private

  def check_input_file!
    if File.exists? input_file_path
      AppLogger.log :info, "Input file '#{ input_file_path }' has been found."
    else
      AppLogger.log :error, "Input file '#{ input_file_path }' doesn't exist."
      exit
    end
  end

  def process
    @parser = Parser.new input_file_path, output_file_path
    @parser.parse

  rescue Errno::ENOENT
    AppLogger.log :error, "Output file '#{ output_file_path }' couldn't be created."
    exit
  end
end
