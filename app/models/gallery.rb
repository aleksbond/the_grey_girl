class Gallery < ActiveRecord::Base
  belongs_to :blog
  has_many :images, :dependent => :destroy
end
