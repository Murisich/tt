# -*- encoding : utf-8 -*-
class PagesController < ApplicationController
  def home
  	@micropost = current_user.microposts.build if signed_in?
  end
end
