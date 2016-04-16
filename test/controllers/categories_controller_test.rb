require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase

	def setup
		@category = Category.create(name: "Sports")
		@user = User.create(username: "John", email: "john@rma.co", password: "password", admin: true)
		@user1 = User.create(username: "John1", email: "john1@rma.co", password: "password", admin: false)
	end
	
	test "should get index successfully" do
		get :index
		assert_response :success
	end

	test "should get new category successfully if you are admin" do
		session[:user_id] = @user.id
		get :new
		assert_response :success
	end

	

	test "should get show category successfully" do
		get(:show, {'id' => @category.id})
		assert_response :success

	end
	
	test "should not create category if user is not admin" do 
	  assert_no_difference 'Category.count' do 
	  	post :create, category: {name: "sport"}
	  end
	  assert_redirected_to categories_path


	end




end
