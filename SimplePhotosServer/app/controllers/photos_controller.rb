class PhotosController < ApplicationController
  def create
    puts self.headers
    p = Photo.new(params[:photo])
    p.save!
    render :xml => "OK"
  rescue
    render :xml => "FAIL"
  end
end


