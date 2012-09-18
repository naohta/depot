require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "product attributes must not be empty" do
    p = Product.new
    assert p.invalid?
    assert p.errors[:title].any?
    assert p.errors[:description].any?
    assert p.errors[:price].any?
    assert p.errors[:image_url].any?
  end

  test "product price must be positive" do
    p = Product.new(title:"My Book Title",
      description:"yyy",
      image_url:"zzz.jpg")

    p.price = -1
    assert p.invalid?
    assert_equal "must be greater than or equal to 0.01",
      p.errors[:price].join('; ')
    
    p.price = 0
    assert p.invalid?
    assert_equal "must be greater than or equal to 0.01",
      p.errors[:price].join('; ')
    
    p.price = 1
    assert p.valid?
  end
end
