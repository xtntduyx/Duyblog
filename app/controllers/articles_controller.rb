class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.paginate(page: params[:page], per_page: 5).order('id DESC')
    #@posts = Post.paginate(:page => params[:page], :per_page => 30).order('id DESC')
  end

  # GET /articles/1
  # GET /articles/1.json
  def show

  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    
  end

  # POST /articles
  # POST /articles.json
  def create
    
    @article = Article.new(article_params)
    
    @article.user = current_user
    #or @article.user_id = current_user.id
    
      if @article.save
        flash[:success] = "Article was successfully created."
        redirect_to article_path(@article)
      else
        render 'new'
      end
    
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
      if @article.update(article_params)
        flash[:success] = "Article was successfully updated."
        redirect_to article_path(@article)
      else
        render 'edit'
      end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    flash[:success] = "Article was successfully deleted."
    redirect_to articles_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :description, category_ids:[])
    end

    def require_same_user
      if current_user != @article.user and !current_user.admin?
        flash[:danger] = "You can only edit your own article."
        redirect_to root_path
      end
    end

end
