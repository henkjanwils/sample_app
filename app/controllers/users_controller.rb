class UsersController < ApplicationController
  before_action :signed_in_user,            only: [:index, :edit, :update, :destroy]
  before_action :correct_user,              only: [:edit, :update]
  before_action :admin_user,                only: :destroy
  before_action :redirect_signed_in_user,   only: [:new, :create]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new( user_params )
    if @user.save
      sign_in @user
      flash[:success] = "We are happy to welcome you at Coursegenerator!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    unless @user.admin?
      @user.destroy
      flash[:success] = "User destroyed."
    end
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user.admin?
    end

    def redirect_signed_in_user
      redirect_to root_url, notice: 'Already logged in' if signed_in?
    end

end
