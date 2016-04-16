class TestSession
  attr_reader :params, :account_id, :uuid, :account

  def initialize(params:, account_id:, uuid:, account:)
    @params = params
    @account_id = account_id
    @uuid = uuid
    @account = account
  end

  def index
    TestAddress.where(account_id: account_id)
  end

  def show
    account.test_addresses.where(uuid: uuid).first
  end

  def create
    account.test_addresses.create(params)
  end

  def destroy
    account.test_addresses.where(uuid: uuid).first.destroy
  end
end

