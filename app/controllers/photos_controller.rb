class PhotosController < ApplicationController
  def index
    matching_photos = Photo.all

    @list_of_photos = matching_photos.order({ :created_at => :desc })

    render({ :template => "photos/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_photos = Photo.where({ :id => the_id })

    @photo = matching_photos.at(0)

    if @current_user == nil
      redirect_to("/user_sign_in", { :notice => "You have to sign in first." })
    else
    render({ :template => "photos/show.html.erb" })
    end
  end

  def create
    

    photo = Photo.new
    photo.caption = params.fetch("query_caption")
    photo.comments_count = 0
    photo.image = params.fetch(:image)
    photo.likes_count = 0
    photo.owner_id = @current_user.id

    if photo.valid?
      photo.save
      redirect_to("/photos", { :notice => "Photo created successfully." })
    else
      redirect_to("/photos", { :alert => photo.errors.full_messages.to_sentence })
    end

  end

  def update
    the_id = params.fetch("path_id")
    photo = Photo.where({ :id => the_id }).at(0)

    photo.caption = params.fetch("query_caption")
    photo.comments_count = params.fetch("query_comments_count")
    photo.image = params.fetch("query_image")
    photo.likes_count = params.fetch("query_likes_count")
    photo.owner_id = params.fetch("query_owner_id")

    if photo.valid?
      photo.save
      redirect_to("/photos/#{photo.id}", { :notice => "Photo updated successfully."} )
    else
      redirect_to("/photos/#{photo.id}", { :alert => photo.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    photo = Photo.where({ :id => the_id }).at(0)

    photo.destroy

    redirect_to("/photos", { :notice => "Photo deleted successfully."} )
  end



end
