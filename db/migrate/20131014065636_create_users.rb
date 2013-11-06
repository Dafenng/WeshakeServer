class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password
      t.string :avatar
      t.string :auth_token
      t.string :user_type
      t.string :type_id
      t.timestamps
    end
  end
end
