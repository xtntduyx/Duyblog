require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @category = Category.create(name: "sports")
    @category1 = Category.create(name: "program")
  end


  test "should show category listing" do
    get categories_path
  	assert_template 'categories/index'
    assert_select "a[href=?]", category_path(@category), text: @category.name
    assert_select "a[href=?]", category_path(@category1), text: @category1.name
  end

  
  	
end

