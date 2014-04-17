
class Profile < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  # validates :avatar, :size => {:in => 0..20.kilobytes}
  # validates :avatar, :size => {:less_than => 40.kilobytes}
  # validates :avatar, :size => {:less_than_or_equal_to => 40.kilobytes}
  # validates :avatar, :size => {:greater_than => 20.kilobytes}
  # validates :avatar, :size => {:greater_than_or_equal_to => 20.kilobytes}
end
