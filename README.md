# ClearSaleClearId

This gem helps to integrate with ClearSale ClearId product. This is done to use
on [PegCar.com][pegcar] and it is designed to fill our needs with less work as
possible. For this reason, some fields are reused between "DadosCobranca" and
"DadosEntrega". Although, all significant code is tested and possible to be
split if you need to use different values on each of the fields.

If you need that, we really encourage you to make an PR with this piece of code.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'clear_sale_clear_id'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install clear_sale_clear_id

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/pegcar/clear_sale_clear_id. This project is intended to be
a safe, welcoming space for collaboration and contributors are expected to
adhere to the [Contributor Covenant](http://contributor-covenant.org) code of
conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

[Pegcar]: www.pegcar.com
