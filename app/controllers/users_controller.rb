class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save

      flash[:info] = "Welcome"
      redirect_to login_path
  	else
  		render "new"
  	end

  end

  def destroy
    @user = User.find(params[:id])
    User.find(params[:id]).destroy
    # @user.destroy
    # respond_to do |format|
    #   format.html { redirect_to @users_url }
    #   format.js
    # end
    redirect_to users_url
  end


  def index
     @users = User.paginate(page: params[:page])
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  	def user_params
		  params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
  	end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user? @user

    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
