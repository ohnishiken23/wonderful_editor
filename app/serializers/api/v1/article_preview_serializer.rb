module Api
  module V1
    class ArticlePreviewSerializer < ActiveModel::Serializer
      attributes :id, :title, :updated_at # 必要な属性を追加する(本文は含めない)
      belongs_to :user, serializer: UserSerializer
    end
  end
end
