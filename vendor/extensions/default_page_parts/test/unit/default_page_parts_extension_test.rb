require File.dirname(__FILE__) + '/../test_helper'

class DefaultPagePartsExtensionTest < Test::Unit::TestCase
  
  setup do
    Radiant::Config['defaults.page.parts']  = 'body, extended'
    Radiant::Config['defaults.page.status'] = 'draft'
  end
  
  def test_should_create_new_page_with_original_defaults
    p = Page.original_new_with_defaults
    assert !p.valid?
    assert_equal(2, p.parts.size)
  end
  
  def test_should_create_new_page_with_new_defaults
    p = Page.new_with_defaults
    assert !p.valid?
    assert_equal(3, p.parts.size)
  end
  
  def test_should_set_default_status
    p = Page.new_with_defaults
    assert !p.valid?
    assert_equal(Status[Radiant::Config['defaults.page.status']], p.status)
  end
  
  def test_new_page_should_contain_correct_parts
    p = Page.new_with_defaults
    assert !p.valid?
    assert_equal(YAML::load(File.open(File.join(File.dirname(__FILE__), 'parts.yml'), 'r')).map { |x| PagePart.new(x) }.inspect, p.parts.inspect)
  end
  
  def test_initialization
    assert_equal File.join(File.expand_path(RAILS_ROOT), 'vendor', 'extensions', 'default_page_parts'), DefaultPagePartsExtension.root
    assert_equal 'Default Page Parts', DefaultPagePartsExtension.extension_name
  end
end
