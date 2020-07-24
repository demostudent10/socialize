class PhotosController < ApplicationController
  before_action :set_photo, only: %i[show edit update destroy]

  def index
    @q = Photo.ransack(params[:q])
    @photos = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def show; end

  def new
    @photo = Photo.new
  end

  def edit; end

  def create
    @photo = Photo.new(photo_params)

    if @photo.save
      redirect_to @photo, notice: "Photo was successfully created."
    else
      render :new
    end
  end

  def update
    if @photo.update(photo_params)
      redirect_to @photo, notice: "Photo was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @photo.destroy
    redirect_to photos_url, notice: "Photo was successfully destroyed."
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:caption)
  end
end
