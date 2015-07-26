require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PaperclipConoha
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
    config.generators do |g|
      g.orm :active_record
      g.template_engine :haml
      g.assets false
      g.helper false
      g.jbuilder false
      g.test_framework(
        :rspec,
        fixture: true,
        fixture_replacement: :factory_girl,
        view_specs: false,
        routing_specs: false,
        controller_specs: false,
        helper_specs: false,
        integration_tool: false
      )
    end

    config.paperclip_defaults = {
      storage: :fog,
      fog_credentials: {
        provider: 'OpenStack',
        openstack_username: ENV['CONOHA_API_USERNAME'],
        openstack_api_key: ENV['CONOHA_API_PASSWORD'],
        openstack_auth_url: ENV['CONOHA_API_AUTH_URL'],
        openstack_tenant: ENV['CONOHA_API_TENANT']
      },
      fog_directory: ENV['CONOHA_OBJECT_STORAGE_DIRECTORY'],
      fog_host: "#{ENV['CONOHA_OBJECT_STORAGE_ENDPOINT']}/#{ENV['CONOHA_OBJECT_STORAGE_DIRECTORY']}"
    }
  end
end
