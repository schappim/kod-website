require File.dirname(__FILE__) + '/../test_helper'

class DefaultPagePartsExtensionTest < Test::Unit::TestCase
  
  # Replace this with your real tests.
  def test_should_create_new_page
    p = Page.original_new_with_defaults
    assert !p.valid?
  end
  
  def test_initialization
    assert_equal File.join(File.expand_path(RAILS_ROOT), 'vendor', 'extensions', 'default_page_parts'), DefaultPagePartsExtension.root
    assert_equal 'Default Page Parts', DefaultPagePartsExtension.extension_name
  end
end
