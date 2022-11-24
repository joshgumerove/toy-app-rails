# frozen_string_literal: true

class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image]) # to actually attach the immag on creation
    if @micropost.save
      redirect_to root_url, notice: 'Post was created!'
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to request.referrer || root_url, notice: 'posted deleted'
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :image) #  must remember to include params at beginning
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
