class PostsController < ApplicationController
	def new
		@post = Post.new

	end

	def show
		@post = Post.find(params[:id])
		@comment = @post.comments.build
		@comments = @post.comments.all
	end

	def create
		@post = current_user.posts.new(post_params)
		if @post.save
			# byebug
			# render json: {
			# 	post_data: render_to_string(@post)
			# }
		redirect_to root_url
		else
			render "static_pages/home"
		end

	end

	def index
		if params[:tag]
      		@tag = Tag.find_by(name: params[:tag])
      		@post = Post.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 20)
		elsif params[:search]
					@post = Post.search(params[:search]).order("created_at DESC").paginate(page: params[:page], per_page: 20)
		else
      		@post = Post.all.paginate(page: params[:page], per_page: 20)
		end
	end

	private

		def post_params
			params.require(:post).permit(:title,:content,:tag_list)
		end
end
