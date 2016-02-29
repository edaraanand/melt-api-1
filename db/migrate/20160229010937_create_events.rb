class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.time :occurred_at

      t.timestamps null: false
    end
  end
end
