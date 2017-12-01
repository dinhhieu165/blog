class StaticPagesController < ApplicationController
  def home
  	@users = User.paginate(page: params[:page])

  	if logged_in?
      @post = current_user.posts.build
  		@feed_items = current_user.feed.paginate(page: params[:page])
  	end
  end
end
