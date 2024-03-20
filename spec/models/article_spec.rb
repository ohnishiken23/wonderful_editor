# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  status     :string           default("draft")
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
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
