class LikesController < ApplicationController
  def index
    matching_likes = Like.all

    @list_of_likes = matching_likes.order({ :created_at => :desc })

    render({ :template => "likes/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_likes = Like.where({ :id => the_id })

    @the_like = matching_likes.at(0)

    render({ :template => "likes/show" })
  end

  #def create
    #the_like = Like.new
    #the_like.fan_id = params.fetch("query_fan_id")
    #the_like.photo_id = params.fetch("query_photo_id")

    #if the_like.valid?
     # the_like.save
     # redirect_to("/photos/#{new_like.photo_id}", { :notice => "Liked successfully." })
    #else
    #  redirect_to("/photos/#{new_like.photo_id}", { :alert => new_like.errors.full_messages.to_sentence })
    #end
  #end

  def create
    new_like = Like.new
    new_like.fan_id = current_user.id
    new_like.photo_id = params.fetch("photo_id")

    if new_like.save
      redirect_to("/photos/#{new_like.photo_id}", { :notice => "Liked successfully." })
    else
      redirect_to("/photos/#{new_like.photo_id}", { :alert => new_like.errors.full_messages.to_sentence })
    end
  end

  def destroy
    like_id = params.fetch("path_id")
    like_to_delete = Like.where({ :id => like_id }).at(0)

    if like_to_delete.present?
      like_to_delete.destroy
      redirect_to("/photos/#{like_to_delete.photo_id}", { :notice => "Unliked successfully." })
    else
      redirect_to("/photos", { :alert => "Like could not be found." })
    end
  end
end

  def update
    the_id = params.fetch("path_id")
    the_like = Like.where({ :id => the_id }).at(0)

    the_like.fan_id = params.fetch("query_fan_id")
    the_like.photo_id = params.fetch("query_photo_id")

    if the_like.valid?
      the_like.save
      redirect_to("/photos/#{the_like.id}", { :notice => "Like updated successfully."} )
    else
      redirect_to("/photos/#{the_like.id}", { :alert => the_like.errors.full_messages.to_sentence })
    end
  end
  #def destroy
    #the_id = params.fetch("path_id")
    #the_like = Like.where({ :id => the_id }).at(0)

    #if the_like.present?
      #like_to_delete.destroy
    #  redirect_to("/photos/#{like_to_delete.photo_id}", { :notice => "Unliked successfully." })
  #  else
   #   redirect_to("/photos", { :alert => "Like could not be found." })
   # end
  #end
end
