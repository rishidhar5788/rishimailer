require 'test_helper'

class EmailControllerTest < ActionDispatch::IntegrationTest
  test "should get sendemail" do
    post email_sendemail_url
    assert_response :success
  end

end
