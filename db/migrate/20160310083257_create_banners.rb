class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :text
      t.string :icon
      t.string :link

      t.timestamps null: false
    end
  end
end
