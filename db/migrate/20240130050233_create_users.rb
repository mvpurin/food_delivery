class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :phone_number
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end
