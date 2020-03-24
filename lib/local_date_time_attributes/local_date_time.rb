require 'delegate'
require 'active_support'
require 'active_support/time'
require 'active_support/time_with_zone'
module LocalDateTimeAttributes
  class LocalDateTime < SimpleDelegator
    def initialize(date_time)
      # We store underlying date_time in utc time. Use self.from_local_datetime instead
      super(from_local(date_time))
    end

    # Returns a datetime in the timezone specified without changing the time
    def to_local(time_zone = Time.zone.try(:name))
      ActiveSupport::TimeZone.new(time_zone).local_to_utc(__getobj__).in_time_zone(time_zone)
    end
    
    private
    
    def from_local(date_time)
      original_time_zone = Rails.config.time_zone
      if date_time.respond_to? :in_time_zone
        original_time_zone = date_time.in_time_zone.time_zone.name
      elsif date_time.respond_to? :time_zone
        original_time_zone = date_time.time_zone.name
      else
        raise ArgumentError "Unable to determine the timezone of #{date_time.inspect}"
      end
      ActiveSupport::TimeZone.new(original_time_zone).local_to_utc(date_time)
    end
  end
end