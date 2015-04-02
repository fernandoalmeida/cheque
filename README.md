# Cheque

A gem to generate cheque copy and cheque printing

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cheque'
```

And then execute:

    bundle

Or install it yourself as:

    gem install cheque

## Usage

### Cheque Copy

```ruby
data = {
  number: 1,
  date: Time.now.to_date,
  bank: 'Citybank',
  agency_number: '123-4'
  account_number: '45678-9'
  amount: '100.00',
  payee: 'Fernando Almeida'
}

copy = Cheque.new(data, :copy)

send_data(copy.render, filename: copy.filename, type: copy.mimetype)
```

### Cheque Printing

```ruby
data = {
  date: Time.now.to_date,
  amount: '100.00',
  payee: 'Fernando Almeida'
}

printing = Cheque.new(data, :printing)

send_data(printing.render, filename: printing.filename, type: printing.mimetype)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment. 

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/fernandoalmeida/cheque/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
