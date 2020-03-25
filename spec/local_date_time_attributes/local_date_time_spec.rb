
describe LocalDateTimeAttributes::LocalDateTime do
  include_context 'with_frozen_time'
  include_context 'with_global_timezone' do
    let(:timezone) { 'Europe/Amsterdam' }
  end
  let(:now) { Time.zone.now }

  subject {LocalDateTimeAttributes::LocalDateTime.new(now)}

  context 'active_record default timezone is UTC' do
    before do
      allow_any_instance_of(LocalDateTimeAttributes::LocalDateTime).to receive(:active_record_timezone).and_return('UTC')
    end

    it 'delegates all method calls' do
      expect(subject.respond_to? :utc).to eql(true)
      expect(subject.is_a? SimpleDelegator).to eql(true)
    end
  end

  describe '#from_local' do
    it 'handles nil' do
      expect(LocalDateTimeAttributes::LocalDateTime.new(nil).to_local).to eql(nil)
    end

    context 'active_record base timezone is UTC' do
      before do
        allow_any_instance_of(LocalDateTimeAttributes::LocalDateTime).to receive(:active_record_timezone).and_return('UTC')
      end

      it 'base time is in UTC' do
        expect(subject.utc?).to eql(true)
      end

      it 'does not change the hour when converting' do
        expect(subject.hour).to eql(now.hour)
      end
    end

    context 'active_record base timezone is not UTC' do
      let(:base_timezone) { 'Australia/Sydney' }
      before do
        allow_any_instance_of(LocalDateTimeAttributes::LocalDateTime).to receive(:active_record_timezone).and_return(base_timezone)
      end

      it 'base time is in utc' do
        expect(subject.time_zone.name).to eql(base_timezone)
      end

      it 'does not change the hour when converting' do
        expect(subject.hour).to eql(now.hour)
      end
    end    
  end

  describe '#to_local' do
    context 'active_record base timezone is UTC' do
      before do
        allow_any_instance_of(LocalDateTimeAttributes::LocalDateTime).to receive(:active_record_timezone).and_return('UTC')
      end
      it 'converts to local timezone' do
        expect(subject.to_local.time_zone.name).to eql(timezone)
      end

      it 'does not change the hour' do
        expect(subject.to_local.hour).to eql(now.hour)
      end
    end
  end
end
