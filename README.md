# Dual

Dual is a gem that helps you clone object in Ruby. It is not tight to any particular
web framework and should work with ease with any PORO.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dual'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dual

## Usage
class Order
  attr_accessor :name, :type, :address

  include Dual

  dual do
    # Exclude a certain attribute from the cloned object
    exclude :type
    # Include a new attribute in the cloned object
    include :email, value: 'test@test.com'
    # Add a guard clause for both include and exclude statements
    include :date, value: Date.today, if: :delivery_incoming?
  end

  def delivery_incoming?
    delivery.today?
  end
end

order = Order.last
dual_order = order.dual_copy

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wizardone/dual. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Dual project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/dual/blob/master/CODE_OF_CONDUCT.md).
