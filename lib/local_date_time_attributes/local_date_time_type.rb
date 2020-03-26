require 'active_record/type'
module LocalDateTimeAttributes
  class LocalDateTimeType < ActiveRecord::Type::DateTime
    def cast(value)
      return LocalDateTime.new(value) if value.acts_like?(:time) && !value.is_a?(LocalDateTime)
      super(value)
    end

    def serialize(value)
      value.try(:__getobj__)
    end

    def deserialize(value)
      cast(value).try(:to_local)
    end
  end
end
