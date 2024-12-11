class FollowRequestsController < ApplicationController
  def index
    matching_follow_requests = FollowRequest.all

    @list_of_follow_requests = matching_follow_requests.order({ :created_at => :desc })

    render({ :template => "follow_requests/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_follow_requests = FollowRequest.where({ :id => the_id })

    @the_follow_request = matching_follow_requests.at(0)

    render({ :template => "follow_requests/show" })
  end

  def create
    recipient_id = params.fetch("query_recipient_id")
    action = params.fetch("action")

    case action
    when "request_follow"
      user = User.where({ :id => recipient_id }).first
      if user.private
        FollowRequest.new({ :sender_id => current_user.id, :recipient_id => user.id, :status => "pending" }).save
      else
        FollowRequest.new({ :sender_id => current_user.id, :recipient_id => user.id, :status => "accepted" }).save
      end
    when "unfollow"
      FollowRequest.where({ :sender_id => current_user.id, :recipient_id => recipient_id, :status => "accepted" }).destroy_all
    when "cancel_request"
      FollowRequest.where({ :sender_id => current_user.id, :recipient_id => recipient_id, :status => "pending" }).destroy_all
    end

    redirect_to users_path
  end

  def update
    the_id = params.fetch("path_id")
    the_follow_request = Follow_Request.where({ :id => the_id }).at(0)

    the_follow_request.recipient_id = params.fetch("query_recipient_id")
    the_follow_request.sender_id = params.fetch("query_sender_id")
    the_follow_request.status = params.fetch("query_status")

    if the_follow_request.valid?
      the_follow_request.save
      redirect_to users_path
    else
      redirect_to users_path
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_follow_request = FollowRequest.where({ :id => the_id }).at(0)

    the_follow_request.destroy

    redirect_to users_path
  end
end
