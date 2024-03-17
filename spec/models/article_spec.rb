require "rails_helper"

RSpec.describe Article, type: :model do
  context "記事のタイトルと本文が入力されているとき" do
    let(:article) { build(:article) }

    it "下書き状態の記事が作成できる" do
      expect(article).to be_valid
      expect(article.status).to eq "draft"
    end
  end

  context "statusがドラフト状態のとき" do
    let(:article) { build(:article, :draft) }

    it "記事を下書き状態で作成できる" do
      expect(article).to be_valid
      expect(article.status).to eq "draft"
    end
  end

  context "statusが公開状態のとき" do
    let(:article) { build(:article, :published) }

    it "記事を公開状態で作成できる" do
      expect(article).to be_valid
      expect(article.status).to eq "published"
    end
  end

  context "記事のタイトルが存在しないとき" do
    it "記事の作成に失敗する" do
      article = Article.new(title: "", body: "sample")
      expect(article.valid?).to eq false
    end
  end
end
