source 'https://rubygems.org'
ruby '>= 2.5.9', '< 2.7'
gem 'rails', '~> 6.0.0'
# ==============================
gem 'autoprefixer-rails'              # automatically add browser prefixes to CSS.
gem 'bootsnap'                        # Bootsnap drastically improves application start times.
gem 'devise'                        # Devise is an authentication gem.
gem 'figaro'                        # For environment variables.
gem 'jbuilder'                      # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'octicons_helper', '~> 4.0'
gem 'pundit'                        # authorization policies
gem 'redcarpet'                     # redcarpet markdown formatting
gem 'render_async'                  # async rendering
gem 'responders'                    # In Rails 5.0 the 'respond_to' and 'respond_with' methods for specifying controller behavior were moved to the responders gem.
gem 'sassc-rails'                   # Use SCSS for stylesheets
gem 'stripe'                        # credit card processing
gem 'uglifier'                      # Use Uglifier as compressor for JavaScript assets
gem 'webrick'                       # Ruby 3 doesn't come with webrick by default anymore.
gem 'webpacker', '6.0.0.rc.5'       # Rails 6 uses webpacker as the default javascript compiler.
gem 'will_paginate'                 # pagination
gem 'will_paginate-bootstrap-style' # Bootstrap 4 and 5 styling for pagination

group :development do
  gem 'web-console'                # Access an IRB console on exception pages or by using <%= console %> in views.
end

group :development, :test do
  gem 'byebug'                     # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'factory_bot_rails'          # Use facoties to build data quickly.
  gem 'faker'                      # Provides classes for creating fake data.
  gem 'listen'                     # Spring and db gems need listen.
  gem 'rspec-rails'
  gem 'rails-controller-testing'   # In Rails 5.0 'assigns' and 'assert_template' have been moved to a different gem.
  gem 'shoulda'                    # Provides more readable test syntax
  gem 'spring', '>= 3'             # The dev environment can automatically reload when it sees files change.
  gem 'sqlite3', '~> 1.4'          # Use sqlite3 as the database for Active Record
end

group :doc do
  gem 'sdoc'                       # bundle exec rake doc:rails generates the API under doc/api.
end

group :production do
  gem 'pg'                        # heroku requires using postgresql for production deploys.
  gem 'rails_12factor'            # heroku requires rails_12factor for ENV variables in production deploys.
 end
 
