# encoding: utf-8

module CarrierWave
  class Railtie < Rails::Railtie
    initializer 'carrierwave.validators' do
      ActiveSupport.on_load :active_record do
        include Validators
      end

      locale_path = Dir.glob(File.dirname(__FILE__) + "/locales/*.{rb,yml}")
      I18n.load_path += locale_path unless I18n.load_path.include?(locale_path)
    end
  end
end
