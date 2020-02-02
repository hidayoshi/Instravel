# frozen_string_literal: true

class ImagepostsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]
  before_action :correct_user,   only: :destroy
  before_action :admin_user,     only: :destroy
  # attr_accessor :avatar

  def create
    @imagepost = current_user.imageposts.build(imagepost_params)
    if @imagepost.save
      flash[:success] = 'Imagepost created!'
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @imagepost.destroy
    flash[:success] = 'imagepost deleted'
    redirect_to request.referer || root_url
  end

  private

  def imagepost_params
    params.require(:imagepost).permit(:content, :picture)
  end

  def correct_user
    @imagepost = current_user.imageposts.find_by(id: params[:id])
    redirect_to root_url if @imagepost.nil?
  end
end
