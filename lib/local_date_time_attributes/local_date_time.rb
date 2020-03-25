require 'delegate'
require 'active_support'
require 'active_support/time'
require 'active_support/time_with_zone'
module LocalDateTimeAttributes
  class LocalDateTime < SimpleDelegator
    def initialize(date_time)
      super(from_local(date_time))
    end

    # Returns a datetime in the timezone specified without changing the time
    def to_local(time_zone = Time.zone.try(:name))
      return if __getobj__.nil? || time_zone.nil?
      ActiveSupport::TimeZone.new(time_zone).local_to_utc(__getobj__).in_time_zone(time_zone)
    end
    
    private
    
    def from_local(date_time)
      return if date_time.nil?
      ActiveSupport::TimeZone.new(active_record_timezone).local_to_utc(date_time).in_time_zone(active_record_timezone)
    end

    def active_record_timezone
      ActiveRecord::Base.default_timezone == :UTC ? 'UTC' : Rails.configuration.time_zone
    end
  end
end