source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Centralization of locale data collection for Ruby on Rails.
gem 'rails-i18n', '~> 5.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# ActiveModel::Serializer implementation and Rails hooks #https://github.com/rails-api/active_model_serializers/tree/0-10-stable
gem 'active_model_serializers', '~> 0.10.0'

# Manage Procfile-based applications http://ddollar.github.com/foreman
gem 'foreman'

# A plugin for versioning Rails based RESTful APIs. 
gem 'versionist'

# Flexible authentication solution for Rails with Warden. http://blog.plataformatec.com.br/tag/…
gem 'devise'

# Token based authentication for Rails JSON APIs. Designed to work with jToker and ng-token-auth.
gem 'devise_token_auth'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # A library for generating fake data such as names, addresses, and phone numbers.
  gem 'capybara'
  gem 'rspec-rails', '~> 3.6'
  gem 'factory_bot_rails', '~> 4.0'
  gem 'faker'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Annotate Rails classes with schema and routes info
  gem 'annotate'
  gem 'spring-commands-rspec'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
