class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :title
      t.string :image
      t.text :desc
      t.date :day
      t.text :credit
      t.belongs_to :page

      t.timestamps
    end
  end
end
