source 'https://rubygems.org'
ruby '>= 2.5.9', '< 2.7'
gem 'rails', '~> 4.2.11'
# ==============================
gem 'autoprefixer-rails'          # automatically add browser prefixes to CSS.
gem 'bootstrap', '~> 4.0'
gem 'bootstrap-will_paginate'     # pagination with bootstrap
gem 'devise'                      # Devise is an authentication gem.
gem 'figaro'                      # For environment variables.
gem 'jbuilder'                    # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jquery-rails'                # required for bootstrap dropdowns
gem 'octicons_helper', '~> 4.0'
gem 'pundit'                      # authorization policies
gem 'rails-ujs'                   # required for native rails js handling of buttons/links
gem 'redcarpet'                   # redcarpet markdown formatting
gem 'render_async'                # async rendering
gem 'sassc-rails'                 # Use SCSS for stylesheets
gem 'stripe'                      # credit card processing
gem 'turbolinks'                  # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'uglifier'                    # Use Uglifier as compressor for JavaScript assets
gem 'will_paginate'               # pagination

# Fixes for dependency issues.
gem 'bigdecimal', '~> 1.4.4'
gem 'sprockets', '< 4'

group :development do
  gem 'web-console'               # Access an IRB console on exception pages or by using <%= console %> in views.
end

group :development, :test do
  gem 'byebug'                    # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'factory_bot_rails', '~> 5' # Use facoties to build data quickly.
  gem 'faker'                  # Provides classes for creating fake data.
  gem 'listen'                    # Spring and db gems need listen.
  gem 'rspec-rails'
  gem 'shoulda', '~> 4'           # Provides more readable test syntax
  gem 'spring', '>= 3'            # The dev environment can automatically reload when it sees files change.
  gem 'sqlite3', '~> 1.3.6'       # Use sqlite3 as the database for Active Record
end

group :doc do
  gem 'sdoc'                      # bundle exec rake doc:rails generates the API under doc/api.
end

group :production do
  gem 'pg', '~> 0.18'             # heroku requires using postgresql for production deploys.
  gem 'rails_12factor'            # heroku requires rails_12factor for ENV variables in production deploys.
 end
 
