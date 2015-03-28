class AddDraftsToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :draft_id, :integer
    add_column :blogs, :published_at, :timestamp
    add_column :blogs, :trashed_at, :timestamp
  end
end
