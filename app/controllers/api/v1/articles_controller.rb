module Api
  module V1
    class ArticlesController < BaseApiController
      # GET /articles
      def index
        articles = Article.order(updated_at: :desc)
        render json: articles, each_serializer: Api::V1::ArticlePreviewSerializer
      end

      # GET /articles/:id
      def show
        article = Article.find(params[:id])
        render json: article, serializer: Api::V1::ArticleSerializer
      end

      # GET /articles/new
      def new
        @article = Article.new
      end

      # POST /articles
      def create
        @article = Article.new(article_params)
        @article.user_id = current_user.id

        if @article.save
          render json: @article, status: :created
        else
          render json: @article.errors, status: :unprocessable_entity
        end
      end

      # PATCH /articles/:id
      def update
        article = Article.find(params[:id])
        article.update!(article_params)
        render json: article, serializer: Api::V1::ArticleSerializer
      end

      private

        def article_params
          params.require(:article).permit(:title, :body)
        end
    end
  end
end
