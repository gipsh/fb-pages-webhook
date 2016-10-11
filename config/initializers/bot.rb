module Facebook
  CONFIG = YAML.load_file(Rails.root.join("config/facebook.yml"))[Rails.env]
  APP_ID = CONFIG['app_id']
  SECRET = CONFIG['secret_key']
  VALIDATION_TOKEN = CONFIG['validation_token']
end

Facebook::Messenger.configure do |config|
  config.access_token = Facebook::APP_ID 
  config.app_secret = Facebook::SECRET
  config.verify_token = Facebook::VALIDATION_TOKEN 
end



unless Rails.env.production?
  bot_files = Dir[Rails.root.join('app', 'bot', '**', '*.rb')]
  bot_reloader = ActiveSupport::FileUpdateChecker.new(bot_files) do
    bot_files.each{ |file| require_dependency file }
  end

  ActionDispatch::Callbacks.to_prepare do
    bot_reloader.execute_if_updated
  end

  bot_files.each { |file| require_dependency file }
end
