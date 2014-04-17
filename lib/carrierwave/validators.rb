# encoding: utf-8

require 'carrierwave/validators/all'
require 'active_support/concern'

module CarrierWave
  module Validators

    extend ActiveSupport::Concern

    included do
      extend HelperMethods
      include HelperMethods
    end

  end
end
