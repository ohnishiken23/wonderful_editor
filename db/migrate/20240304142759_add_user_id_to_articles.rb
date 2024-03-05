class AddUserIdToArticles < ActiveRecord::Migration[6.1]
  def change
    # add_reference :articles, :user, null: false, foreign_key: true
    add_reference :articles, :user, foreign_key: true
  end
end
