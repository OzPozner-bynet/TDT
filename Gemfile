source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0.1'
# Use postgresql as the database for Active Record
gem 'pg' #, '~> 0.17'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
 gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'haml'
gem 'devise', github: 'plataformatec/devise'
gem 'simple_form', '~>3.3.1'
gem 'paperclip'
gem 'bootstrap-sass'
gem 'sidekiq'
gem 'sidetiq', github: 'sfroehler/sidetiq', branch: 'celluloid-0-17-compatibility'
#gem 'pubnub',  github: 'pubnub/ruby', branch: 'celluloid'
gem 'redis', '~>3.2'
gem 'sinatra', :require => nil

group :development do
  gem 'pry'
  gem 'pry-rails'
end
#gem 'fileutils', '<0.7.1'
gem 'activerecord-postgis-adapter'
gem 'GeoRuby'
gem 'win32-open3-19', :platforms => :mingw
gem 'POpen4'
gem 'activeadmin_settings_cached' 
gem "devise_ldap_authenticatable", :git => "git://github.com/cschiewek/devise_ldap_authenticatable.git"
#gem 'sprockets-rails', :require => 'sprockets/railtie'
gem "ransack"
gem "will_paginate" , "3.1.5"
group :production do
 gem 'therubyracer', :platform => :ruby
end
gem 'twitter-bootstrap-rails', "<3.2.2"
