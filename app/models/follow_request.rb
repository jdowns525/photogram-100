# == Schema Information
#
# Table name: follow_requests
#
#  id           :integer          not null, primary key
#  status       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recipient_id :integer
#  sender_id    :integer
#
class FollowRequest < ApplicationRecord
  belongs_to(:photo, { :required => true, :class_name => "User", :foreign_key => "photo_id" })
  belongs_to(:author, { :required => true, :class_name => "Photo", :foreign_key => "author_id" })
end
