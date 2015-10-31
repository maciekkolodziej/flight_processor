class Parser
  attr_reader :input_file_path, :output_file_path, :output_file, :new_entries, :valid_entries, :invalid_entries,
              :headers

  def initialize(input_file_path, output_file_path)
    @input_file_path = input_file_path
    @output_file_path = output_file_path
    @headers = %i(id carrier_code flight_number flight_date)
    self
  end

  def parse
    @new_entries = []
    CSV.read(input_file_path, headers: true).each do |row|
      attributes = Hash[headers.each_with_index.map{ |key, i| [key, row[i]]}]
      @new_entries << Flight.new(attributes)
    end
    process_entries
    self
  end

  private

  def process_entries
    @valid_entries = []
    @invalid_entries = []
    @new_entries.each do |entry|
      if entry.valid?
        valid_entries << entry
      else
        invalid_entries << entry
      end
    end
    save_results
  end

  def save_results
    if valid_entries.empty?
      AppLogger.log :error, 'Input file processed successfully, but no valid entries were found.'
    else
      save_valid_entries
      AppLogger.log :info, "#{ valid_entries.count } entries saved to #{ output_file_path } output file."
    end

    unless invalid_entries.empty?
      save_invalid_entries
      AppLogger.log :info, "#{ invalid_entries.count } invalid entries saved to errors.csv file."
    end
  end

  def save_valid_entries
    CSV.open(output_file_path, 'w', write_headers: true, headers: headers) do |csv|
      valid_entries.each{ |entry| csv << entry.to_a }
    end
  end

  def save_invalid_entries
    errors_headers = headers << :errors
    CSV.open('errors.csv', 'w', write_headers: true, headers: errors_headers) do |csv|
      invalid_entries.each{ |entry| csv << entry.to_invalid_a }
    end
  end
end
