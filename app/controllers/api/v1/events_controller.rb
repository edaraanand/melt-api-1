class Api::V1::EventsController < ApplicationController
  respond_to :json

  before_action :authenticate

  def index
    @events = Event.all
    respond_with @events
  end

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      @user = User.where(api_key: token).first
    end
  end
end
