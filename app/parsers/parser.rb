class Parser
  attr_reader :input_file_path, :output_file_path, :input, :output_file, :entries

  def initialize(input_file_path, output_file_path)
    @input_file_path = input_file_path
    @output_file_path = output_file_path
    @input = File.read(input_file_path)

    prepare_output_file
    self
  end

  def parse
    @entries = []
    CSV.parse(input) do |row|
      attributes = Hash[%i(id carrier_code flight_number flight_date).each_with_index.map{ |key, i| [key, row[i]]}]
      @entries << Flight.new(attributes)
    end
    process_entries
    self
  end

  private

  def process_entries
    @entries.each{ |e| puts e.inspect }
  end

  def prepare_output_file
    @output_file = File.open(output_file_path, 'w')
  end
end
