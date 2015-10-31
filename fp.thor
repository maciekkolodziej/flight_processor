class Fp < Thor
  desc 'start', 'Reads input file, processes it, and outputs results to output file.'
  method_option :input_file, default: 'data/sample_input.csv', aliases: '-i',
                desc: 'Path to input file with flight data.'
  def start
    $:.unshift Dir.pwd
    require 'app'
    App.new(options)
  end
end
