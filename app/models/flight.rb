class Flight
  include Virtus.model
  include ActiveModel::Validations

  attribute :id, String
  attribute :carrier_code_type, String
  attribute :carrier_code, String
  attribute :flight_number, String
  attribute :flight_date, Date

  validates :id, :carrier_code, :flight_number, :flight_date, presence: true
  validate :validate_date
  validate :validate_carrier_code

  ICAO_REGEXP = /\A[a-zA-Z]{3}\z/.freeze
  IATA_REGEXP = /\A[a-zA-Z\d]{2}\*?\z/.freeze

  def to_a
    [id, carrier_code_type, carrier_code, flight_number, flight_date]
  end

  def to_invalid_a
    to_a << errors.full_messages.join('. ')
  end

  private

  def validate_date
    errors.add(:flight_date, 'is not a valid date') unless flight_date.is_a? Date
  end

  def validate_carrier_code
    if carrier_code =~ ICAO_REGEXP
      self.carrier_code_type = 'ICAO'
    elsif carrier_code =~ IATA_REGEXP
      self.carrier_code_type = 'IATA'
    else
      errors.add(:carrier_code, :invalid)
    end
  end
end
