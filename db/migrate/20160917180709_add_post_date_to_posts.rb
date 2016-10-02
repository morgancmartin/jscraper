class AddPostDateToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :post_date, :date
  end
end
