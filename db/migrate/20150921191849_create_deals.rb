class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :title
      t.string :image
      t.text :description
      t.integer :goal
      t.string :location
      t.datetime :start
      t.datetime :end
      t.boolean :published, default: false
      t.boolean :private, default: false
      t.integer :amount

      t.timestamps null: false
    end
  end
end
