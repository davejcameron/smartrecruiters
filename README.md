# SmartRecruiters

API wrapper for the SmartRecruiters API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'smartrecruiters'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install smartrecruiters

## Usage

To access the API, you'll need to create a `SmartRecruiters::Client`

```ruby
client = SmartRecruiters::Client.new(api_key: ENV["SMARTRECRUITERS_API_KEY"])
```

To configure for the sandbox environment

```ruby
client = SmartRecruiters::Client.new(api_key: ENV["SMARTRECRUITERS_API_KEY"], environment: "sandbox")
```

## Resources

### Access Groups

```ruby
client.access_groups
```

### Candidates

```ruby
client.candidates.list
client.candidates.create({})
client.candidates.retrieve(candidate_id: "id")
client.candidates.update(candidate_id: "id", {})
client.candidates.delete(candidate_di: "id")
client.candidates.retrieve_consent(candidate_id: "id")
client.candidates.retrieve_consents(candidate_id: "id")
client.candidates.retrieve_application(candidate_id: "id", job_id: "id")
client.candidates.retrieve_application_attachments(candidate_id: "id", job_id: "id")
client.candidates.retrieve_status_history(candidate_id: "id", job_id: "id")
```

### Interviews

```ruby
client.interviews.create({})
client.interviews.retrieve(interview_id: "id")
client.interviews.update(interview_id: "id", {})
client.interviews.delete(interview_id:)
```

### Interview Types

```ruby
client.interview_types.list
client.interview_types.create(interview_types: ["type"])
client.interview_types.delete(interview_type: "type")
```

### Jobs

```ruby
client.jobs.list
client.jobs.retrieve(job_id: "id")
client.jobs.list_hiring_team(job_id: "id")
```

### Offers

```ruby
client.offers.list
client.offers.retrieve_offer(offer_id: "id", candidate_id: "id", job_id: "id")
client.offers.retrieve_offers(candidate_id: "id", job_id: "id")
```

### Reports

```ruby
client.reports.list
client.reports.retrieve(report_id: "id")
```

### Reviews

```ruby
client.reviews.list
client.reviews.create({})
client.reviews.retrieve(review_id: "id")
client.reviews.update(review_id: "id", {})
client.reviews.delete(review_id: "id", reviewer_id: "id")
```

### System Roles

```ruby
client.system_roles.list
```

### Users

```ruby
client.users.list
client.users.create({})
client.users.retrieve(user_id: "id")
client.users.update(user_id: "id", {})
client.users.activate(user_id: "id")
client.users.activation_email(user_id: "id")
client.users.deactivate(user_id: "id")
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/davejcameron/smartrecruiters. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SmartRecruiters project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/smartrecruiters/blob/master/CODE_OF_CONDUCT.md).
