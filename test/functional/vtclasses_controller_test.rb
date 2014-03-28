require 'test_helper'

class VtclassesControllerTest < ActionController::TestCase
  setup do
    @vtclass = vtclasses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vtclasses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vtclass" do
    assert_difference('Vtclass.count') do
      post :create, vtclass: { course_number: @vtclass.course_number, subject_code: @vtclass.subject_code }
    end

    assert_redirected_to vtclass_path(assigns(:vtclass))
  end

  test "should show vtclass" do
    get :show, id: @vtclass
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vtclass
    assert_response :success
  end

  test "should update vtclass" do
    put :update, id: @vtclass, vtclass: { course_number: @vtclass.course_number, subject_code: @vtclass.subject_code }
    assert_redirected_to vtclass_path(assigns(:vtclass))
  end

  test "should destroy vtclass" do
    assert_difference('Vtclass.count', -1) do
      delete :destroy, id: @vtclass
    end

    assert_redirected_to vtclasses_path
  end
end
