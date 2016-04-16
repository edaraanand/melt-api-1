class Sessionizer
  def initialize(params:, account_id:, uuid:, session:, account:)
    @params = params
    @account_id = account_id
    @uuid = uuid
    @session = session
    @account = account
  end

  def index
    current_session.index
  end

  def show
    current_session.show
  end

  def create
    current_session.create
  end

  def destroy
    current_session.destroy
  end

  private

  attr_reader :params, :account_id, :uuid, :session, :account

  def current_session
    case session
    when "TEST"
      TestSession.new(
        params:     params,
        account_id: account_id,
        uuid:       uuid,
        account:    account
      )
    when "LIVE"
      LiveSession.new(
        params:     params,
        account_id: account_id,
        uuid:       uuid,
        account:    account
      )
    end
  end
end

