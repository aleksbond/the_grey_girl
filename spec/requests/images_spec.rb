require 'spec_helper'

RSpec.describe "Images", :type => :request do
  describe "GET /images" do
    it "works! (now write some real specs)" do
      get images_path
      expect(response.status).to be(200)
    end
  end
end
