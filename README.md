# ApmTraceable

[![Gem Version](https://badge.fury.io/rb/apm_traceable.svg)](https://badge.fury.io/rb/apm_traceable)
[![Build Status](https://github.com/kokuyouwind/apm_traceable/actions/workflows/main.yml/badge.svg)](https://github.com/kokuyouwind/apm_traceable/actions/workflows/main.yml)

APM で任意区間のトレースを取得するためのライブラリです。

## Installation

この Gem と、利用する APM に対応するアダプタの2つを Gemfile に記述します。

```ruby
gem 'apm_traceable'
gem 'apm_traceable-datadog' # Datadogの場合
```

その後、以下を実行してください。

    $ bundle install

アダプタの設定方法は各 Gem を参照してください。
組み込みの `ApmTraceable::Adapters::StdoutAdapter` であれば、以下のように設定します。

```ruby
ApmTraceable.configure do |config|
  config.adapter = 'stdout'
end
```

## Usage

トレースを取得するクラスごとに `ApmTraceable::Tracer` を include します。

その後、トレースを取得したいメソッドを `trace_methods` に指定するか、 `trace_span` を利用してブロックを指定します。

```ruby
class TracerTestClass
  include ApmTraceable::Tracer

  trace_methods :test_trace_method
  def test_trace_method
    'test'
  end

  def test_trace_span
    trace_span('test_name', option1: :value1) do 
      'test'
    end
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kokuyouwind/apm_traceable.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
