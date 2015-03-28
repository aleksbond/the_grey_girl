class Blog < ActiveRecord::Base
  has_drafts
  has_one :gallery
  paginates_per 1
end
