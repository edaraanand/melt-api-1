require "rails_helper"

describe HomesController do
  context "the user is not logged in" do
    it "redirects to /show" do
      get :show

      expect(response).to be_success
      expect(response).to render_template(:show)
    end
  end
end
