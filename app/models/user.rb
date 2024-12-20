# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  comments_count         :integer
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  likes_count            :integer
#  password_digest        :string
#  private                :boolean
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  def follows?(other_user)
    FollowRequest.exists?({ :sender_id => self.id, :recipient_id => other_user.id, :status => "accepted" })
  end

  def pending_follow_request_for(other_user)
    FollowRequest.where({ :sender_id => self.id, :recipient_id => other_user.id, :status => "pending" }).first
  end

  def followed_users
    # Find accepted follow requests where the current user is the sender
    accepted_follow_requests = FollowRequest.where({ :sender_id => self.id, :status => "accepted" })
    followed_user_ids = accepted_follow_requests.map(&:recipient_id)
    
    # Retrieve the users who are being followed
    followed_users = User.where({ :id => followed_user_ids })
    return followed_users
  end

  def followers
    # Find accepted follow requests where the current user is the sender
    accepted_follow_requests = FollowRequest.where({ self.id => :sender_id, :status => "accepted" })
    followed_user_ids = accepted_follow_requests.map(&:recipient_id)
    
    # Retrieve the users who are being followed
    followed_users = User.where({ :id => followed_user_ids })
    return followed_users
  end

  #has_secure_password
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many  :comments, class_name: "Comment", foreign_key: "author_id", dependent: :destroy
  has_many  :followrequests, class_name: "Followrequest", foreign_key: "sender_id", dependent: :destroy
  has_many  :likes, class_name: "Like", foreign_key: "fan_id", dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
end
