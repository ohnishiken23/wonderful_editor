class Api::V1::BaseApiController < ApplicationController
  def current_user
    # 仮実装として、users テーブルの一番初めのユーザーを返す
    User.first
  end
end
