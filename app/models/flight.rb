class Flight
  include Virtus.model

  attribute :id, String
  attribute :carrier_code, String
  attribute :flight_number, String
  attribute :flight_date, Date
end
