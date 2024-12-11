# == Schema Information
#
# Table name: photos
#
#  id             :bigint           not null, primary key
#  caption        :string
#  comments_count :integer
#  image          :string
#  likes_count    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  owner_id       :integer
#
class Photo < ApplicationRecord
  has_many :comments, :class_name => "Comment", :foreign_key => "photo_id", :dependent => :destroy
  has_many :likes, :class_name => "Like", :foreign_key => "photo_id", :dependent => :destroy
end
