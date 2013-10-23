class ChangeTypeIdToUsers < ActiveRecord::Migration
  def change
    change_column :users, :type_id, :string
  end
end
