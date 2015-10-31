class Flight
  include Virtus.model
  include ActiveModel::Validations

  attribute :id, String
  attribute :carrier_code, String
  attribute :flight_number, String
  attribute :flight_date, Date

  validates :id, :carrier_code, :flight_number, :flight_date, presence: true
  validate :validate_date

  def carrier_code_type
    'TYPE'
  end

  def to_a
    [id, carrier_code, flight_number, flight_date]
  end

  def to_invalid_a
    to_a << errors.full_messages.join('. ')
  end

  private

  def validate_date
    errors.add(:flight_date, 'is not a valid date') unless flight_date.is_a? Date
  end
end
