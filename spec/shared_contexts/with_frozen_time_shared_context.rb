RSpec.shared_context "with_frozen_time", :shared_context => :metadata do
  around do |example|
    Timecop.freeze do
      example.run
    end
  end
end