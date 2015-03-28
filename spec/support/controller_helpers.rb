module ControllerHelpers
  def login_admin
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    sign_in FactoryGirl.create(:admin) # Using factory girl as an example
  end
end