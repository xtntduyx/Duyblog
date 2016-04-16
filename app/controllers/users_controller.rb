class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]

    def index
      @users = User.paginate(page: params[:page], per_page: 5).order('id DESC')
      #@posts = Post.paginate(:page => params[:page], :per_page => 30).order('id DESC')
    end


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
   	  flash[:success] = "Your account is created. Welcome to the Duywork #{@user.username}"
   	  redirect_to user_path(@user)
    else
     render 'new'
    end
  end

  def show
    #@user = User.find(params[:id])
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5).order('@user.articles.id DESC')
  end


  def edit
    #@user = User.find(params[:id])
  end

  def update
    #@user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Your account is updated sucesfully"
   	  redirect_to articles_path
    else
      render 'edit'
    end

  end




  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "User and all articles created by user have been deleted."
    redirect_to users_path
  
  end

private
     #Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def require_same_user
      if current_user != @user and !current_user.admin?
        flash[:danger] = "You can only edit your own account."
        redirect_to root_path
      end
    end

    def require_admin
      if logged_in? and !current_user.admin?
        flash[:danger] = "Only admin users can perform that action."
        redirect_to root_path
      end
    end



end
