require "rails_helper"

RSpec.describe Article, type: :model do
  context "記事のタイトルが存在しないとき" do
    it "記事の作成に失敗する" do
      article = Article.new(title: "", body: "sample")
      expect(article.valid?).to eq false
    end
  end
end
