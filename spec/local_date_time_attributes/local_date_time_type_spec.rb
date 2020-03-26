require 'spec_helper'
describe LocalDateTimeAttributes::LocalDateTimeType do
  include_context 'with_frozen_time'
  include_context 'with_global_timezone' do
    let(:timezone) { 'Europe/Amsterdam' }
  end
  let(:now) { Time.zone.now }
  let(:local_date_time_double) {double(LocalDateTimeAttributes::LocalDateTime)}

  before do
    allow_any_instance_of(LocalDateTimeAttributes::LocalDateTime).to receive(:active_record_timezone).and_return('UTC')
  end

  describe '#cast' do
    it 'returns a LocalDateTime instance' do
      expect(subject.cast(now)).to be_a LocalDateTimeAttributes::LocalDateTime
    end

    it 'returns if the value is already a LocalDateTimeAttributes::LocalDateTime' do
      local_date_time = LocalDateTimeAttributes::LocalDateTime.new(Time.now)
      expect(subject.cast(local_date_time)).to eql(local_date_time)
    end

    it 'returns nil if value is nil' do
      expect(subject.cast(nil)).to eql(nil)
    end

    it 'calls super if the value cannot be cast' do
      object = Object.new
      expect(subject.cast(object)).to eql(object)
    end

  end

  describe '#serialize' do
    it 'returns the converted timestamp' do
      expect(local_date_time_double).to receive(:__getobj__).and_return(now)
      expect(subject.serialize(local_date_time_double)).to eql(now)
    end

    it 'returns nil if value is nil' do
      expect(subject.serialize(nil)).to be_nil
    end

  end

  describe '#deserialize' do
    it 'calls to_local on the converted timestamp' do
      expect(subject).to receive(:cast).and_return(local_date_time_double)
      expect(local_date_time_double).to receive(:to_local).and_return(now)
      expect(subject.deserialize(local_date_time_double)).to eql(now)
    end

    it 'returns nil if the value is nil' do
      expect(subject.deserialize(nil)).to be_nil
    end

  end
end