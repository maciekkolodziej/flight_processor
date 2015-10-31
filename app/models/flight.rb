class Flight
  include Virtus.model
  include ActiveModel::Validations

  attribute :id, String
  attribute :carrier_code, String
  attribute :flight_number, String
  attribute :flight_date, Date

  validates :id, :carrier_code, :flight_number, :flight_date, presence: true
  validate :validate_date
  validate :validate_carrier_code

  ICAO_REGEXP = /\A[a-zA-Z]{3}\z/.freeze
  IATA_REGEXP = /\A[a-zA-Z\d]{2}\*?\z/.freeze

  def carrier_code_type
    if carrier_code =~ ICAO_REGEXP
      'ICAO'
    elsif carrier_code =~ IATA_REGEXP
      'IATA'
    else
      nil
    end
  end

  def to_a
    [id, carrier_code_type, carrier_code, flight_number, flight_date.to_s]
  end

  def to_invalid_a
    to_a << errors.full_messages.join('. ')
  end

  private

  def validate_date
    errors.add(:flight_date, 'is not a valid date') unless flight_date.is_a? Date
  end

  def validate_carrier_code
    errors.add(:carrier_code, :invalid) if carrier_code_type.nil?
  end
end
