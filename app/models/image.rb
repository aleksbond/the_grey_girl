class Image < ActiveRecord::Base
  belongs_to :gallery
  has_attached_file :file, :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
                    :url  => "/images/:id/:filename", 
                    :path => ":rails_root/public/images/:id/:filename", 
                    :default_url => "/images/:style/missing.png"
  do_not_validate_attachment_file_type :file
end
