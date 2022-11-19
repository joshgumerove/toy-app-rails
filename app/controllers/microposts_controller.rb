# frozen_string_literal: true

class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
        redirect_to root_url, notice: "Post was created!"
    else
        render "static_pages/home"
    end
  end

  def destroy
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content) #  must remember to include params at beginning
  end
end
