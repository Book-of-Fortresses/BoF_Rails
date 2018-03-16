require 'test_helper'

class PerspectiveDrawingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @perspective_drawing = perspective_drawings(:one)
  end

  test "should get index" do
    get perspective_drawings_url
    assert_response :success
  end

  test "should get new" do
    get new_perspective_drawing_url
    assert_response :success
  end

  test "should create perspective_drawing" do
    assert_difference('PerspectiveDrawing.count') do
      post perspective_drawings_url, params: { perspective_drawing: {  } }
    end

    assert_redirected_to perspective_drawing_url(PerspectiveDrawing.last)
  end

  test "should show perspective_drawing" do
    get perspective_drawing_url(@perspective_drawing)
    assert_response :success
  end

  test "should get edit" do
    get edit_perspective_drawing_url(@perspective_drawing)
    assert_response :success
  end

  test "should update perspective_drawing" do
    patch perspective_drawing_url(@perspective_drawing), params: { perspective_drawing: {  } }
    assert_redirected_to perspective_drawing_url(@perspective_drawing)
  end

  test "should destroy perspective_drawing" do
    assert_difference('PerspectiveDrawing.count', -1) do
      delete perspective_drawing_url(@perspective_drawing)
    end

    assert_redirected_to perspective_drawings_url
  end
end
