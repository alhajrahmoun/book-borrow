require 'test_helper'

class PenaltiesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get penalties_new_url
    assert_response :success
  end

  test "should get edit" do
    get penalties_edit_url
    assert_response :success
  end

end
