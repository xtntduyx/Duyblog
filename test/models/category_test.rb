require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  
  def setup
    @category = Category.new(name: "Sports")
  end

  test "category should be valid" do
    assert @category.valid?
  end

  test "category should not be blank" do
	@category.name = "" 
	assert_not @category.valid?  
  end

  test "category name should not have less than 3 characters" do
    @category.name = "aa"
    assert_not @category.valid?
  end

  test "category name should not have more than 26 characters" do
    @category.name = "a"*26
    assert_not @category.valid?
  end
  
  test "category name should not match with the existing category" do
    @category.save
    @category2 = Category.new(name: "Sports")
    assert_not @category2.valid?
  end
  

end