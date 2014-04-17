require 'spec_helper'

describe CarrierWave::Validators::SizeValidator do
  before(:each) do
    @profile = Profile.new(name: "John Doe")
  end

  context ":in option" do
    before(:all) do
      Profile.class_eval do
        Profile.clear_validators!
        validates :avatar, :size => {:in => 0..20.kilobytes}
      end
    end

    context "When uploaded file is within specified range" do

      it "file is valid" do
        @profile.avatar = Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/small.png")
        expect(@profile.valid?).to eq true
      end
    end

    context "When uploaded file is out of range" do
      before(:each) do
        @profile.avatar = Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/avatar.jpg")
        @profile.save
      end

      it "file is invalid" do
        expect(@profile.valid?).to eq false
      end

      it "invalid error message is generated" do
        expect(@profile.errors.full_messages).to include "Avatar file size must be in between 0 Bytes and #{20.kilobytes} Bytes"
      end
    end

  end

  context ":less_than option" do
    before(:all) do
      Profile.class_eval do
        Profile.clear_validators!
        validates :avatar, :size => {:less_than => 40.kilobytes}
      end
    end
    context "When uploaded file size is less than the specified value" do

      it "file is valid" do
        @profile.avatar = Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/avatar.jpg")
        expect(@profile.valid?).to eq true
      end
    end

    context "When uploaded file size is greater than or equal to specified value" do
      before(:each) do
        @profile.avatar = Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/large.jpg")
      end

      it "file is invalid" do
        expect(@profile.valid?).to eq false
      end

      it "invalid error message is generated" do
        @profile.save
        expect(@profile.errors.full_messages).to include "Avatar file size must be less than #{40.kilobytes} Bytes"
      end
    end
  end

  context ":less_than_or_equal_to option" do
    before(:all) do
      Profile.class_eval do
        Profile.clear_validators!
        validates :avatar, :size => {:less_than_or_equal_to => 40.kilobytes}
      end
    end
    context "When uploaded file size is less than or equal to specified value" do

      it "file is valid" do
        @profile.avatar = Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/avatar.jpg")
        expect(@profile.valid?).to eq true
      end
    end

    context "When uploaded file size is greater than the specified value" do
      before(:each) do
        @profile.avatar = Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/large.jpg")
      end

      it "file is invalid" do
        expect(@profile.valid?).to eq false
      end

      it "invalid error message is generated" do
        @profile.save
        expect(@profile.errors.full_messages).to include "Avatar file size must be less than or equal to #{40.kilobytes} Bytes"
      end
    end
  end

  context ":greater_than option" do
    before(:all) do
      Profile.class_eval do
        Profile.clear_validators!
        validates :avatar, :size => {:greater_than => 20.kilobytes}
      end
    end
    context "When uploaded file size is greater than the specified value" do

      it "file is valid" do
        @profile.avatar = Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/avatar.jpg")
        expect(@profile.valid?).to eq true
      end
    end

    context "When uploaded file size is less than or equal to specified value" do
      before(:each) do
        @profile.avatar = Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/small.png")
      end

      it "file is invalid" do
        expect(@profile.valid?).to eq false
      end

      it "invalid error message is generated" do
        @profile.save
        expect(@profile.errors.full_messages).to include "Avatar file size must be greater than #{20.kilobytes} Bytes"
      end
    end
  end

  context ":greater_than_or_equal_to option" do
    before(:all) do
      Profile.class_eval do
        Profile.clear_validators!
        validates :avatar, :size => {:greater_than_or_equal_to => 20.kilobytes}
      end
    end
    context "When uploaded file size is greater than or equal to specified value" do

      it "file is valid" do
        @profile.avatar = Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/avatar.jpg")
        expect(@profile.valid?).to eq true
      end
    end

    context "When uploaded file size is less than the specified value" do
      before(:each) do
        @profile.avatar = Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/small.png")
      end

      it "file is invalid" do
        expect(@profile.valid?).to eq false
      end

      it "invalid error message is generated" do
        @profile.save
        expect(@profile.errors.full_messages).to include "Avatar file size must be greater than or equal to #{20.kilobytes} Bytes"
      end
    end
  end

end
