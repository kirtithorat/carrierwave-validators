# CarrierWave-Validators

CarrierWave extension to validate uploaded files.

## Installation

Install the latest stable release:

    $[sudo] gem install carrierwave-validators

In Rails, add it to your Gemfile:

    gem 'carrierwave-validators'

And then execute:

    $ bundle

Finally, restart the server to apply the changes.

## Getting Started

`Carrierwave-Validators` supports following validators to validate your attachment:

* `SizeValidator` - Validates the file size of uploaded file

## SizeValidator

SizeValidator validates the **file size** of files uploaded using `CarrierWave`.

Example Usage, in the model `User` with Carrierwave attachment `avatar`:

    class User < ActiveRecord::Base
      mount_uploader :avatar, AvatarUploader
      validates :avatar, :size => { :in => 0..50.kilobytes } ## Validates if uploaded file is within 0 Bytes to 50 KiloBytes
    end

Alternatively,

     validates :avatar, :size => { :in => 0..50.kilobytes }

can be specified as

     validates_file_size :avatar, :in => 0..50.kilobytes  

Available options:

* *in* : in between a Range of bytes , for example 

        ## uploaded file size is within 0 Bytes to 50 KiloBytes
        validates :avatar, :size => { :in => 0..50.kilobytes } 

* *less_than* : less than a number in bytes, for example  

        ## uploaded file size is less than 5 MegaBytes
        validates :avatar, :size => { :less_than => 5.megabytes } 

* *greater_than* : greater than a number in bytes, for example 

        ## uploaded file size is greater than 5 KiloBytes
        validates :avatar, :size => { :greater_than => 5.kilobytes } 

* *less_than_or_equal_to* : less than or equal to a number in bytes, for example  

        ## uploaded file size is less than or equal to 1 MegaByte
        validates :avatar, :size => { :less_than_or_equal_to => 1.megabytes } 

* *greater_than_or_equal_to* : greater than or equal to a number in bytes, for example  

        ## uploaded file size is greater than or equal to 5 KiloBytes
        validates :avatar, :size => { :greater_than_or_equal_to => 5.kilobytes } 

* *message* : error message to display, for example  

         validates :avatar, :size => { :in => 0..50.kilobytes, :message => "Your custom error message" }   

#i18n

The Active Record validations use the Rails i18n framework. Include the following keys in your translation files:

    en:
      errors:
        messages:
          in: "file size must be in between %{min} %{min_unit} and %{max} %{max_unit}"
          greater_than: "file size must be greater than %{count} %{unit}"
          greater_than_or_equal_to: "file size must be greater than or equal to %{count} %{unit}"
          less_than: "file size must be less than %{count} %{unit}"
          less_than_or_equal_to: "file size must be less than or equal to %{count} %{unit}"

      size:
        units:
          one: "Byte"
          other: "Bytes"

## TODO

* Add content-type validation        

