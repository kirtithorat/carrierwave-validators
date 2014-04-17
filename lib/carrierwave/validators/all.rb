# encoding: utf-8

require "carrierwave/validators/version"
require "carrierwave/validators/error"

if defined? Rails
  require "carrierwave/validators/railtie"
  require "carrierwave/validators/size_validator"
end