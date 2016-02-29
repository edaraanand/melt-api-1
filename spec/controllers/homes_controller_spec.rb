require "rails_helper"

describe HomesController do
  context "the user is not logged in" do
    it "redirects to /show" do
      get :show

      expect(response).to be_success
      expect(response).to render_template(:show)
    end
  end

  context "the user is logged in" do
    it "redirects to user's dashboard" do
      user = create(:user)
      sign_in_as(user)

      get :show

      expect(response).to redirect_to(dashboard_path)
    end
  end
end
