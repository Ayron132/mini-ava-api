source "https://rubygems.org"


gem "rails", "~> 7.2.1", ">= 7.2.1.2"

gem "pg", "~> 1.1"

gem "puma", ">= 5.0"

gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false


group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false

  
  gem "letter_opener", "~> 1.10"
end



gem "devise_token_auth", "~> 1.2"


gem "active_model_serializers", "~> 0.10.15"

gem "devise", "~> 4.9"

gem "rack-cors", "~> 2.0"
