class Blog < ActiveRecord::Base
  has_drafts
  has_one :gallery
end
