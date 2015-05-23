require 'test_helper'

class EpreuvesControllerTest < ActionController::TestCase
  setup do
    @epreufe = epreuves(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:epreuves)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create epreufe" do
    assert_difference('Epreufe.count') do
      post :create, epreufe: {  }
    end

    assert_redirected_to epreufe_path(assigns(:epreufe))
  end

  test "should show epreufe" do
    get :show, id: @epreufe
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @epreufe
    assert_response :success
  end

  test "should update epreufe" do
    patch :update, id: @epreufe, epreufe: {  }
    assert_redirected_to epreufe_path(assigns(:epreufe))
  end

  test "should destroy epreufe" do
    assert_difference('Epreufe.count', -1) do
      delete :destroy, id: @epreufe
    end

    assert_redirected_to epreuves_path
  end
end
