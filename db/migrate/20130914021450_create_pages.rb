class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :url
      t.boolean :is_copyright

      t.timestamps
    end
  end
end
