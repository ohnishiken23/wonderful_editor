require "rails_helper"

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  context "emailが重複ないとき" do
    it "ユーザーが作られる" do
      # user = User.new(name: "ken", email: "ken@example.com", password: "123456")
      user = create(:user)
      expect(user).to be_valid
    end
  end

  # context "emailが重複しているとき" do
  #   User.create!(name: "foo", email: "foo@example.com", password: "123456")
  # user = User.new(name: "foo", email: "foo@example.com", uid: 0, provider: "")
  #   let(:user) { build(:user, email: "foo@example.com") }
  #   fit "ユーザー作成に失敗する" do
  #     expect(user).to be_invalid
  #   end
  # end

  context "ユーザー名が存在しないとき" do
    it "ユーザー作成に失敗する" do
      user = User.new(email: "foo@example.com", password: "123456")
      expect(user).to be_invalid
    end
  end

  context "名前のみ入力しているとき" do
    it "ユーザー作成に失敗する" do
      user = User.new(name: "foo")
      expect(user).to be_invalid
    end
  end

  context "必要な情報が揃っている場合" do
    let(:user) { build(:user) }

    it "ユーザー登録できる" do
      expect(user).to be_valid
    end
  end

  context "名前のみ入力している場合" do
    let(:user) { build(:user, email: nil, password: nil) }

    it "エラーが発生する" do
      expect(user).not_to be_valid
    end
  end

  context "email がない場合" do
    let(:user) { build(:user, email: nil) }

    it "エラーが発生する" do
      expect(user).not_to be_valid
    end
  end

  context "password がない場合" do
    let(:user) { build(:user, password: nil) }

    it "エラーが発生する" do
      expect(user).not_to be_valid
    end
  end
end
