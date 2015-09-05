class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :title
      t.text :content
      t.references :user, index: true, foreign_key: true
      t.references :projects, index: true, foreign_key: true
      t.text :tags

      t.timestamps null: false
    end
  end
end
