class ArticlesController < ApplicationController
    # Restringe o acesso às ações de criar, editar e excluir para usuários autenticados
    before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :authorize_user, only: [:edit, :update, :destroy]
  
    
    def index
      @articles = Article.all
    end
  
    
    class ArticlesController < ApplicationController
      def show
        @article = Article.find(params[:id])
        @comments = @article.comments
      end
    end
    def new
      @article = current_user.articles.build
    end
  
    def create
      @article = current_user.articles.build(article_params)
      if @article.save
        redirect_to @article, notice: 'Publicação criada com sucesso!'
      else
        render :new
      end
    end
  
    
    def edit
    end
  
    def update
      if @article.update(article_params)
        redirect_to @article, notice: 'Publicação atualizada com sucesso!'
      else
        render :edit
      end
    end
  
    
    def destroy
      @article.destroy
      redirect_to articles_path, notice: 'Publicação excluída com sucesso!'
    end
  
    private
  
    def set_article
      @article = Article.find(params[:id])
    end
  
    def article_params
      params.require(:article).permit(:title, :body)
    end
  
    def authorize_user
      redirect_to articles_path, alert: 'Permissão negada!' unless @article.user == current_user
    end
  
    def require_login
      redirect_to new_session_path, alert: 'Você precisa estar logado.' unless current_user
    end
  end
  