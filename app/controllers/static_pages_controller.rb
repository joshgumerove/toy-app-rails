# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    # puts "what is it #{Rails.env}" not how we can find out the current rails environment
  end

  def help; end

  def about; end

  def contact; end
end
