class CommentsController < ApplicationController
	def create
		@comment = Comment.new(comment_params)
		@comment.user_id = current_user.id

		if @comment.save
			render json: {
				comment_data: render_to_string(@comment)
			}
			# redirect_to @post
		else
			flash[:success] = @comment
			render "static_pages/home"
		end
	end

	private
		def comment_params
			params.require(:comment).permit(:content, :post_id)
		end
end
