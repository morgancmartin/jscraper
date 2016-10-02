class AddCityStateToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :city, :string
    add_column :posts, :state, :string
  end
end
