# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  image                  :string
#  name                   :string
#  provider               :string           default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  tokens                 :json
#  uid                    :string           default(""), not null
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#
require "rails_helper"

RSpec.describe User, type: :model do
  context "emailが重複ないとき" do
    it "ユーザーが作られる" do
      user = create(:user)
      expect(user.valid?).to eq true
    end
  end

  context "emailが重複しているとき" do
    let(:exist_user) { create(:user) }
    let(:user) { build(:user, email: exist_user.email) }

    it "ユーザー作成に失敗する" do
      expect(user.valid?).to eq false
    end
  end

  context "ユーザー名が存在しないとき" do
    let(:user) { User.new(email: "foo@example.com", password: "123456") }
    it "ユーザー作成に失敗する" do
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
