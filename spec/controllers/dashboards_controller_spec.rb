require "rails_helper"

describe DashboardsController do
  context "the user is logged in" do
    it "redirects to user's dashboard" do
      user = create(:user)
      sign_in user

      get :dashboard

      expect(response).to be_success
      expect(response).to render_template(:dashboard)
    end
  end
end
