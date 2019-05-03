class RemoveArticleIdFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_reference :users, :article
  end
end
