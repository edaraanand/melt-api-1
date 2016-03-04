class Api::V1::BaseController < ApplicationController
  protect_from_forgery with: :null_session

  before_action :destroy_session

  def destroy_session
    request.session_options[:skip] = true
  end

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      @account = Account.where(test_api_key: token).first
    end
  end
end
