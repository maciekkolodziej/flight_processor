require 'spec_helper'

RSpec.describe Flight do
  subject { FactoryGirl.build(:flight) }
  it { expect(subject.valid?).to be true}

  describe '#id' do
    it { expect(subject.id).to eq('10009266-0-0-0') }

    context 'when id is empty' do
      before do
        subject.id = ''
        subject.valid?
      end

      it { expect(subject.errors[:id].count).to eq(1) }
      it { expect(subject.valid?).to be false }
    end
  end

  describe '#carrier_code' do
    it { expect(subject.carrier_code).to eq('TG') }

    context 'when carrier code is empty' do
      before do
        subject.carrier_code = ''
        subject.valid?
      end

      it { expect(subject.errors[:carrier_code].count).to eq(2) }
      it { expect(subject.valid?).to be false }
    end

    context 'when carrier code has 4 alphabetic chars' do
      before do
        subject.carrier_code = 'TGGG'
        subject.valid?
      end

      it { expect(subject.errors[:carrier_code].count).to eq(1) }
      it { expect(subject.valid?).to be false }
    end

    context 'when carrier code has 3 chars with number)' do
      before do
        subject.carrier_code = 'TG1'
        subject.valid?
      end

      it { expect(subject.errors[:carrier_code].count).to eq(1) }
      it { expect(subject.valid?).to be false }
    end

    context 'when carrier code has 2 chars with special sign' do
      before do
        subject.carrier_code = 'T%'
        subject.valid?
      end

      it { expect(subject.errors[:carrier_code].count).to eq(1) }
      it { expect(subject.valid?).to be false }
    end

    context 'when carrier code has 2 alphanumeric chars with special sign' do
      before do
        subject.carrier_code = 'T1'
        subject.valid?
      end

      it { expect(subject.valid?).to be true }
    end

    context 'when carrier code has 2 alphanumeric chars with asterix' do
      before do
        subject.carrier_code = 'T1*'
        subject.valid?
      end

      it { expect(subject.valid?).to be true }
    end

    context 'when carrier code has 3 alphabetic chars' do
      before do
        subject.carrier_code = 'AAA'
        subject.valid?
      end

      it { expect(subject.valid?).to be true }
    end
  end

  describe '#flight_number' do
    it { expect(subject.flight_number).to eq('7165') }

    context 'when flight_number is empty' do
      before do
        subject.flight_number = ''
        subject.valid?
      end

      it { expect(subject.errors[:flight_number].count).to eq(1) }
      it { expect(subject.valid?).to be false }
    end
  end

  describe '#flight_date' do
    it { expect(subject.flight_date.to_s).to eq('2013-01-25') }

    context 'when flight_date is empty' do
      before do
        subject.flight_date = ''
        subject.valid?
      end

      it { expect(subject.errors[:flight_date].count).to eq(2) }
      it { expect(subject.valid?).to be false }
    end

    context 'when flight_date is invalid' do
      before do
        subject.flight_date = '2015-31-31'
        subject.valid?
      end

      it { expect(subject.errors[:flight_date].count).to eq(1) }
      it { expect(subject.valid?).to be false }
    end
  end

  describe '#carrier_code_type' do
    it { expect(subject.carrier_code_type).to eq('IATA') }

    context 'when carrier code has 4 alphabetic chars' do
      before { subject.carrier_code = 'TGGG' }

      it { expect(subject.carrier_code_type).to eq(nil) }
    end

    context 'when carrier code has 3 chars with number)' do
      before { subject.carrier_code = 'TG1' }

      it { expect(subject.carrier_code_type).to eq(nil) }
    end

    context 'when carrier code has 2 chars with special sign' do
      before { subject.carrier_code = 'T%' }

      it { expect(subject.carrier_code_type).to eq(nil) }
    end

    context 'when carrier code has 2 alphanumeric chars with special sign' do
      before { subject.carrier_code = 'T1' }

      it { expect(subject.carrier_code_type).to eq('IATA') }
    end

    context 'when carrier code has 2 alphanumeric chars with asterix' do
      before { subject.carrier_code = 'T1*' }

      it { expect(subject.carrier_code_type).to eq('IATA') }
    end

    context 'when carrier code has 3 alphabetic chars' do
      before { subject.carrier_code = 'AAA' }

      it { expect(subject.carrier_code_type).to eq('ICAO') }
    end
  end

  describe '#to_a' do
    it { expect(subject.to_a).to eq(%w(10009266-0-0-0 IATA TG 7165 2013-01-25)) }
  end

  describe '#to_invalid_a' do
    it { expect(subject.to_invalid_a).to eq(['10009266-0-0-0', 'IATA', 'TG', '7165', '2013-01-25', '']) }

    context 'when carrier code is empty' do
      before do
        subject.carrier_code = ''
        subject.valid?
      end

      it { expect(subject.to_invalid_a).to eq(['10009266-0-0-0', nil, '', '7165', '2013-01-25',
                                               "Carrier code can't be blank. Carrier code is invalid"]) }
    end
  end
end
