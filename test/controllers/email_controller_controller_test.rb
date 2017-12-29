require 'test_helper'

class EmailControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get sendemail" do
    get email_controller_sendemail_url
    assert_response :success
  end

end
