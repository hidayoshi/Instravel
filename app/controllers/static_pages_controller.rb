# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @user = current_user
      @imagepost = current_user.imageposts.build
      @feed_items = current_user.feed.page(params[:page]).per(10)
    end
  end
end
