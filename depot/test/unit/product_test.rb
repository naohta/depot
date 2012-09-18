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

  def new_product(image_url)
    Product.new(title:"My Book Title",
      description:"yyy",
      price: 1,
      image_url: image_url)
  end

  test "image_url" do
    ok = %w{fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
      httpl//a.b.c/x/y/z/fred.gif}
    bad = %w{fred.doc, fred.gif/more fred.gif.more}

    ok.each do |name|
      assert new_product(name).valid?, "#{name} shouldn't be invalid"
    end

    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end
  end

end
