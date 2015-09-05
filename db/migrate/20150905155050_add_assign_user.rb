class AddAssignUser < ActiveRecord::Migration
  def change
    add_column :issues, :assigned_to, :integer
  end
end
