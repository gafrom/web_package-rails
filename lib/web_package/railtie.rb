require 'rails/railtie'

module WebPackage
  # Integration into Rails middleware pipeline.
  class Railtie < ::Rails::Railtie
    initializer 'web_package.configure_rails_initialization' do |app|
      app.middleware.insert 0, Middleware
    end
  end
end
