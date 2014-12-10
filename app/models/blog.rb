class Blog < ActiveRecord::Base
  has_many :images
  paginates_per 1
end
