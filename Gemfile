source 'https://rubygems.org'

ruby File.read('.ruby-version').strip

gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'rack-cors'

gem 'graphql'

group :test do
  gem 'rspec-rails'
  gem 'timecop'
end

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end


group :lint do
  gem 'rubocop', require: false
end
