class Fp < Thor
  desc 'start', 'Reads input file, processes it, and outputs results to output file.'

  method_option :input_file, aliases: '-i',
                default: 'data/sample_input.csv',
                desc: 'Path to input file with flight data.'

  method_option :output_file, aliases: '-o',
                default: 'data/sample_output.csv',
                desc: 'Path to output file.'

  method_option :quiet, aliases: '-q',
                default: false,
                desc: 'Quiet mode.'

  def start
    $:.unshift Dir.pwd
    require 'app'
    App.new(options)
  end
end
