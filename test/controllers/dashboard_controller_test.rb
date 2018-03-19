require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get all_accounts" do
    get dashboard_all_accounts_url
    assert_response :success
  end

end
