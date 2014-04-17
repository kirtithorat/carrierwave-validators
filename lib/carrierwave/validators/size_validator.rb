# encoding: utf-8

require 'active_model/validations/numericality'

module CarrierWave
  module Validators

    class SizeValidator < ActiveModel::Validations::NumericalityValidator
      AVAILABLE_CHECKS = [:less_than, :less_than_or_equal_to, :greater_than, :greater_than_or_equal_to].freeze

      def initialize(options)
        extract_options(options)
        super
      end

      def validate_each(record, attribute, value)
        unless value.blank?
          raise(CarrierWave::Validators::InvalidAttributeError, "A CarrierWave::Uploader::Base object was expected") unless value.kind_of? CarrierWave::Uploader::Base
          value = value.respond_to?(:length) ? value.length : value.to_s.length

          options.slice(*AVAILABLE_CHECKS).each do |option, option_value|
            unless value.send(CHECKS[option], option_value)
              error_message_key = options[:in] ? :in : option
              record.errors.add(attribute, error_message_key, filtered_options(value).merge!(detect_error_options(option, option_value)))
            end
          end
        end
      end

      def check_validity!
        unless (AVAILABLE_CHECKS + [:in]).any? { |argument| options.has_key?(argument) }
          raise CarrierWave::Validators::InvalidOptionError, "List of allowed options - [:in, :less_than, :greater_than, :less_than_or_equal_to, :greater_than_or_equal_to]"
        end

        options.slice(*AVAILABLE_CHECKS).each do |option, value|
          isNumeric = value.is_a?(Numeric)

          unless isNumeric && value >= 0
            error_message = options[:in] ? ":in value must be in a non-negative Range" : ":#{option} value must be a non-negative Number"
            raise CarrierWave::Validators::InvalidOptionError, error_message
          end

          if isNumeric && value == 0 && ([:less_than, :less_than_or_equal_to].include? option)
            error_message = options[:in] ? "Invalid value for :in option. Lower bound must be greater than 0." : "Invalid value for :#{option} option. It must be greater than 0."
            raise CarrierWave::Validators::InvalidOptionError, error_message
          end

        end
      end

      private

      def extract_options(options)
        if range = options[:in]
          raise CarrierWave::Validators::InvalidOptionError, ":in must be a Range" unless range.is_a?(Range)
          clear_options(options)
          options[:less_than_or_equal_to], options[:greater_than_or_equal_to] = range.max, range.min
        end
      end

      def clear_options(options)
        AVAILABLE_CHECKS.each do |option|
          options.delete(option)
        end
      end

      def detect_error_options(option, option_value)
        if options[:in]
          max = options[:less_than_or_equal_to]
          min =  options[:greater_than_or_equal_to]
          error_options = { min: min, max: max, min_unit: detect_unit(min), max_unit: detect_unit(max) }
        else
          error_options = { count: option_value, unit: detect_unit(option_value) }
        end
      end

      def detect_unit(option_value)
        I18n.translate(:"size.units", count: option_value, :raise => true )
      end

    end

    module HelperMethods
      # Places ActiveModel validations on the size of the file assigned. The
      # possible options are:
      # * +in+: in between a Range of bytes 
      # * +less_than+: less than a number in bytes 
      # * +greater_than+: greater than a number in bytes 
      # * +less_than_or_equal_to+: less than or equal to a number in bytes
      # * +greater_than_or_equal_to+: greater than or equal to a number in bytes
      # * +message+: error message to display, use :min and :max as replacements
      def validates_file_size(*attr_names)
        validates_with SizeValidator, _merge_attributes(attr_names)
      end
    end

  end
end
