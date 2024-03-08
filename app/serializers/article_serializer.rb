class ArticleSerializer < ActiveModel::Serializer
  attributes :id
  attributes %i[id title]
end
