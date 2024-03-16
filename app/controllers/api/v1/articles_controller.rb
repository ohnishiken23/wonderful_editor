module Api
  module V1
    class ArticlesController < BaseApiController
      before_action :authenticate_user!, only: [:create, :update, :destroy]

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

      # POST /articles
      def create
        article = Article.new(article_params)
        article.user_id = current_user.id

        if article.save
          render json: article, serializer: Api::V1::ArticleSerializer, status: :created
        else
          render json: article.errors, status: :unprocessable_entity
        end
      end

      # PATCH /articles/:id
      def update
        article = current_user.articles.find(params[:id])
        article.update!(article_params)
        render json: article, serializer: Api::V1::ArticleSerializer
      end

      # DELETE /articles/:id
      def destroy
        article = current_user.articles.find(params[:id])
        article.destroy!
      end

      private

        def article_params
          params.require(:article).permit(:title, :body)
        end
    end
  end
end
