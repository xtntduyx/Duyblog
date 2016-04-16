require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create(username: "John", email: "john@rma.co", password: "password", admin: true)
  end



  test "get new category form and create category" do
    #login. sign_in_as is defined under test_helper.rb
    sign_in_as(@user, "password")
    get new_category_path
  	assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
    	post_via_redirect categories_path, category: {name: "sports"}
    end
    assert_template 'categories/index'
    assert_match "sports", response.body
  end

   test "redirect to new page if we do not input anything to create  category" do
    #login. sign_in_as is defined under test_helper.rb
    sign_in_as(@user, "password")
    get new_category_path
  	assert_template 'categories/new'
    assert_no_difference 'Category.count' do
    	post categories_path, category: {name: ""}
    end
    assert_template 'categories/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  	
end

