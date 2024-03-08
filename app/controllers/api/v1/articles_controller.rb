module Api
  module V1
    class ArticlesController < BaseApiController
      # GET /articles
      def index
        articles = Article.order(updated_at: :desc)
        render json: articles, each_serializer: Api::V1::ArticlePreviewSerializer
      end

      # GET /articles/1
      def show
        article = Article.find(params[:id])
        render json: article
      end

      # GET /articles/new
      def new
        @article = Article.new
      end

      # POST /articles
      def create
        @article = Article.new(article_params)
        if @article.save
          redirect_to @article, notice: "Article was successfully created."
        else
          render :new, status: :unprocessable_entity
        end
      end

      private

        # def set_article
        #   @article = Article.find(params[:id])
        # end

        def article_params
          params.require(:article).permit(:title, :body)
        end
    end
  end
end
