require 'local_date_time_attributes/local_date_time_type'
module LocalDateTimeAttributes
  class Railtie < Rails::Railtie
    initializer "local_date_time_attributes.types" do
      ActiveRecord::Type.register(:local_date_time, LocalDateTime::LocalDateTimeType)
    end
  end
end