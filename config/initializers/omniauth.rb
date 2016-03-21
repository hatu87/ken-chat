OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['195004957542776'], ENV['a30d0b1ea48bec874e4e115c23ae1637']
end
