class LikesController < ApplicationController
  def create
  	@like = Like.new(like_params)
  	@like.post_id = params[:id]
  	if @like.save
  		respond_to do |format|
        format.html { redirect_to @like.post }
        format.js 
      end
  	end
  end

  def destroy
    # Like.liked(current_user.id,params[:id]).destroy
    @like = Like.find( params[:id]).destroy
    redirect_to @like.post
  end

  private

    def like_params
    	params.require(:like).permit(:user_id)
    end
end
