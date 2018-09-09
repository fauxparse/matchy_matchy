# MatchyMatchy

A cute little implementation of the [Stable Match
algorithm](http://www.nrmp.org/), built by and for
the [New Zealand Improv Festival](https://nzif.info).

[![Maintainability](https://api.codeclimate.com/v1/badges/e9b46ac5ed632d5c83f6/maintainability)](https://codeclimate.com/github/fauxparse/matchy_matchy/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/e9b46ac5ed632d5c83f6/test_coverage)](https://codeclimate.com/github/fauxparse/matchy_matchy/test_coverage)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'matchy_matchy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install matchy_matchy

## Usage

The `MatchMaker` takes two sets of data:

* a `Hash` of `candidates` and their preferred targets
* a `Hash` of `targets` to tuples containing their preferred targets and the
  number of candidates they're allowed to select

Calling `perform` on a `MatchMaker` yields an object that can return the
assignments keyed either `by_candidate` or `by_target`.

```ruby
candidates = {
  'Arthur'  => %w[City],
  'Sunny'   => %w[City Mercy],
  'Joseph'  => %w[City General Mercy],
  'Latha'   => %w[Mercy City General],
  'Darrius' => %w[City Mercy General],
}

targets = {
  'Mercy'   => [%w[Darrius Joseph], 2],
  'City'    => [%w[Darrius Arthur Sunny Latha Joseph], 2],
  'General' => [%w[Darrius Arthur Joseph Latha], 2],
}

results = MatchyMatchy::MatchMaker.perform(
  targets: targets,
  candidates: candidates
)

results.by_candidate
# {
#  'Arthur'  => 'City',
#  'Sunny'   => nil,
#  'Joseph'  => 'General',
#  'Latha'   => 'General',
#  'Darrius' => 'City',
# }

results.by_target
# {
#  'Mercy'   => []
#  'City'    => ['Darrius', 'Arthur'],
#  'General' => ['Joseph', 'Latha'],
# }
```

The `candidates` and `targets` can be pretty much any type of object.  They can
even clash, which makes it safe to use things like database IDs unambiguously:
equal objects that are referenced in both collections will be treated separately
by the `MatchMaker`.

You can also specify the `targets` without an explicit capacity, in which case a
default capacity of `1` will be assumed:

```ruby
targets = {
  'Mercy'   => %w[Darrius Joseph],
  'City'    => %w[Darrius Arthur Sunny Latha Joseph],
  'General' => %w[Darrius Arthur Joseph Latha],
}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome
[on GitHub](https://github.com/fauxparse/matchy_matchy).
This project is intended to be a safe, welcoming space for collaboration, and
contributors are expected to adhere to the [Contributor
Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT
License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MatchyMatchy project’s codebases, issue trackers,
chat rooms and mailing lists is expected to follow the [code of
conduct](https://github.com/fauxparse/matchy_matchy/blob/master/CODE_OF_CONDUCT.md).
