RSpec.shared_context "with_global_timezone", :shared_context => :metadata do
  around do |example|
    Time.use_zone(timezone) { example.run }
  end
end