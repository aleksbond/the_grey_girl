class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.timestamps
    end
    
    add_reference :galleries, :blog, index: true
  end
end
