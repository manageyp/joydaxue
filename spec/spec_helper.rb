require 'spork'

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
Spork.prefork do
  RSpec.configure do |config|
  # The settings below are suggested to provide a good initial experience
  # with RSpec, but feel free to customize to your heart's content.

    # These two settings work together to allow you to limit a spec run
    # to individual examples or groups you care about by tagging them with
    # `:focus` metadata. When nothing is tagged with `:focus`, all examples
    # get run.
    # config.filter_run :focus => true
    config.run_all_when_everything_filtered = true

    # Many RSpec users commonly either run the entire suite or an individual
    # file, and it's useful to allow more verbose output when running an
    # individual spec file.
    # if config.files_to_run.one?
    #   # Use the documentation formatter for detailed output,
    #   # unless a formatter has already been configured
    #   # (e.g. via a command-line flag).
    #   config.default_formatter = 'doc'
    # end

    # Print the 10 slowest examples and example groups at the
    # end of the spec run, to help surface which specs are running
    # particularly slow.
    # config.profile_examples = 10

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    # config.order = :random

    # Seed global randomization in this process using the `--seed` CLI option.
    # Setting this allows you to use `--seed` to deterministically reproduce
    # test failures related to randomization by passing the same `--seed` value
    # as the one that triggered the failure.
    # Kernel.srand config.seed

    # rspec-expectations config goes here. You can use an alternate
    # assertion/expectation library such as wrong or the stdlib/minitest
    # assertions if you prefer.
    config.use_transactional_fixtures = true
    # warning old `:should`  new `:expect`
    config.mock_with :rspec do |mocks|
      mocks.syntax =  [:should, :expect]
    end

    config.expect_with :rspec do |expectations|
      expectations.syntax = [:should, :expect]
    end

    config.include RSpec::Rails::RequestExampleGroup, file_path: /spec\/api/

    config.include FactoryGirl::Syntax::Methods

  end
end

Spork.each_run do
  FactoryGirl.reload
  Dir["#{Rails.root}/app/**/**/*.rb"].each do |file|
    load file
  end
end
