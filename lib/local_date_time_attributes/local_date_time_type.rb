require 'active_record/type'
module LocalDateTimeAttributes
  class LocalDateTimeType < ActiveRecord::Type::DateTime
    def cast(value)
      if value.instance_of? LocalDateTime
        return value
      elsif !value.nil?
        LocalDateTime.new(value)
      end
    end

    def serialize(value)
      value.try(:__getobj__)
    end

    def deserialize(value)
      cast(value).to_local
    end
  end
end
