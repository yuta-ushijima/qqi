class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.string :post_status, index: true , null: false, default: "draft"

      t.timestamps
    end
  end
end
