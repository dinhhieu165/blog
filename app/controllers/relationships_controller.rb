class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :find_user, :verify_state_params, only: :index

  def index
    @users = @user.send(params[:state]).paginate(page: params[:page])
    render 'users/show_follow'
  end

  def create
    user = User.find(params[:followed_id])
    respond_to do |format|
      if current_user.follow(user)
        format.html do
          flash[:success] = "Following user successfully"
          redirect_to @user
        end
        format.js do

        end
        format.json do

        end
      else
        format.html do
          flash[:danger] = "Can't following this user"
          redirect_to @user
        end
        format.js do

        end
        format.json do

        end
      end
    end
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  private

  def verify_state_params
    return if User::RELATIONSHIP.include?(params[:state])

    flash[:danger] = "Access denied!!!"
    redirect_to root_path
  end

  def find_user
    @user  = User.find_by id: params[:id]
    return if @user

    flash[:danger] = "Not found user with id #{params[:id]}"
    redirect_to root_path
  end
end
