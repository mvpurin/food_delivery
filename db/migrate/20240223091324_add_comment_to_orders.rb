class AddCommentToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :comment, :text, default: nil
  end
end
