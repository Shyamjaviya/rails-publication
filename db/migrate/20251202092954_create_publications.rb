class CreatePublications < ActiveRecord::Migration[8.1]
  def change
    create_table :publications do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :content
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
