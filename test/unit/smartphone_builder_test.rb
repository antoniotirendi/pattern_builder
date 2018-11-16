require_relative '../test_case'

class SmartphoneBuilderTest < Test::Unit::TestCase
  def test_create_without_build
    smartphone_builder = SmartphoneBuilder.new

    products = []

    (1..8).each do |version|
      smartphone_builder.set_model("Samsung S#{version}")
      smartphone_builder.set_os('Android')
      smartphone_builder.add_processor(2.8)
      smartphone_builder.add_ram(4096)
      smartphone_builder.add_memory(32768)
      smartphone_builder.add_touchscreen(4.5)
      products << smartphone_builder.smartphone
    end

    assert_equal 8, products.count
    assert_equal 'Samsung S8', products.last.model
  end

  def test_create_with_build
    products = []

    (1..4).each do |version|
      smartphone = SmartphoneBuilder.build do |builder|
        builder.set_model("Samsung S#{version}")
        builder.set_os('Android')
        builder.add_processor(2.8)
        builder.add_ram(4096)
        builder.add_memory(32768)
        builder.add_touchscreen(4.5)
      end
      products << smartphone
    end

    assert_equal 4, products.count
    assert_equal 'Samsung S4', products.last.model
  end

  def test_validations
    assert_builder_raise('Model is required', ->(builder){builder.set_model(nil)})
    assert_builder_raise('Operating system is required', ->(builder){builder.set_os(nil)})
    assert_builder_raise('Operating system unknown', ->(builder){builder.set_os('puppa')})
    assert_builder_raise('Processor speed is required', ->(builder){builder.add_processor(nil)})
    assert_builder_raise('RAM size is required', ->(builder){builder.add_ram(nil)})
    assert_builder_raise('Memory is required', ->(builder){builder.add_memory(nil)})
    assert_builder_raise('Screen size is required', ->(builder){builder.add_touchscreen(nil)})
  end

  private

  def assert_builder_raise(message, block)
    assert_raise(RuntimeError.new(message)) {SmartphoneBuilder.build {|builder| block.call(builder)}}
  end
end