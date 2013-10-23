class AddTypeAndTypeIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :type, :string
    add_column :users, :type_id, :integer
  end
end
