# frozen_string_literal: true

class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      redirect_to user, notice: 'account activated!'
    else
      redirect_to root_url, notice: 'invalid activation link'
    end
  end
end
