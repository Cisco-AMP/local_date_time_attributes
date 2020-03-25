# LocalDateTimeAttributes

Leverages the active_record attributes api to define a custom active_record type `local_date_time`. Normally, active_record will convert a Time,DateTime,Date which has a timezone into the active_record's base timezone - performing conversion of the time in the process. This custom attribute will ignore the timezone component of the `Time` attribute.

Sometimes it is preferrable to ignore the timezone defined by [Time.zone](https://api.rubyonrails.org/classes/ActiveSupport/TimeZone.html) before persisting or loading from persistence. In otherwords, the time_zone component is ignored prior to saving to the database and after loading from database

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'local_date_time_attributes'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install local_date_time_attributes


## Usage

On an active_record model, just add an attribute with the type `:local_date_time`

    class Interview < ApplicationRecord
      attribute :start_at, :local_date_time
    end

We will have a date_time attribute on ProductUpdate.start_at that ignores timezone prior to persisting and after loading



    $ Time.zone = 'Eastern Time (US & Canada)'
      => "Eastern Time (US & Canada)"

    # active_record is setup to use a different timezone
    $ ActiveRecord::Base.default_timezone
      => :utc

    $ time = Time.zone.local(2007, 2, 10, 15, 30, 45)
      => Sat, 10 Feb 2007 15:30:45 EST -05:00

    # Timezone is ignored when saving to a database
    $ Interview.new(start_at: time).save
       (0.4ms)  BEGIN
      SQL (4.7ms)  UPDATE `interviews` SET `start_at` = '2007-02-10 15:30:45', `updated_at` = '2020-03-25 18:06:11' WHERE `product_updates`.`id` = 1
       (1.5ms)  COMMIT

    $ interview = Interview.first

    $ interview.start_at
      => Sat, 10 Feb 2007 15:30:45 EST -05:00

    # timezone is ignored when loading
    $ Time.use_zone('Asia/Singapore') { product_update.reload.start_at }
      => Sat, 10 Feb 2007 15:30:45 +08 +08:00
      
## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Cisco-AMP/local_date_time_attributes.
