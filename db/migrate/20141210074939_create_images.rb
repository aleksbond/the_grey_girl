class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|            
      t.timestamps
    end
    
    add_reference :images, :gallery, index: true
    
  end
end
