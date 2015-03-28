FactoryGirl.define do
  factory :admin do
    email "admin@the_grey_girl.com"
    password "fooobaar"
    password_confirmation {|u| u.password}
  end
end