source 'https://rubygems.org'
ruby '2.3.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.10'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'bootstrap'
gem 'octicons-rails'
gem 'octicons_helper'
gem 'autoprefixer-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Devise is an authentication gem.
gem 'devise'

# For environment variables.
gem 'figaro', '1.0'

# redcarpet markdown formatting
gem 'redcarpet', '~> 3.4.0'

# async rendering
gem 'render_async'

# authorization policies
gem 'pundit'

# credit card processing
gem 'stripe'

# pagination with bootstrap
gem 'will_paginate'
gem 'bootstrap-will_paginate'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  
  # Run rpsec tests.
  gem 'rspec-rails'
  
  # Use facoties to build data quickly.
  gem 'factory_bot_rails'
  
  # for creating fake data.
  gem 'faker'
  
  # for easier test syntax
  gem 'shoulda'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
end

group :production do
  gem 'pg', '~> 0.18'
  gem 'rails_12factor'
end

