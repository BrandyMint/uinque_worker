# UniqueWorker

[![Build Status](https://travis-ci.org/BrandyMint/unique_worker.svg)](https://travis-ci.org/BrandyMint/unique_worker)

Модуль предназначет для исключения ситуации
когда один воркер выполняется параллельно.
В большинстве случаев это не нужно и опасно (напирмер нет смысла параллельно генерировать новый valuta.xml)
В тоже время письма параллельно можно отправлять.

Можно было бы применить схему один worker = одна очередь и ограничить ее одним job-ом
но нам нет смысла держать job-ы в очереди, их надо просто исключать

http://erik.debill.org/2016/08/07/sidekiq-queueing-patterns

Это пока сырой технический вариант. По-сути является надстройкой над RedLock. У него есть зависимость от Settings и от
Rails. Если испытания пройдут успешно, то нужно будет:

1. Выделить настройки в configure модуля.
2. Сделать возможность лочить любой метод и как следсвие отдельный helper для
   worker-ов.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'unique_worker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install unique_worker

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dapi/unique_worker. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the UniqueWorker project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/dapi/unique_worker/blob/master/CODE_OF_CONDUCT.md).
