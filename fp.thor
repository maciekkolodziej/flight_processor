class Fp < Thor
  desc 'start', 'Reads input file, processes it, and outputs results to output file.'
  def start
    $:.unshift Dir.pwd
    puts 'Welcome to flight processor.'
  end
end
