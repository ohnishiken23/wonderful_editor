class AddStatusToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :status, :string, default: "draft"
  end
end
