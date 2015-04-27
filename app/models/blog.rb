class Blog < ActiveRecord::Base
  has_drafts
  has_one :gallery
  paginates_per 5
end
