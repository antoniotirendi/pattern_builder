class SmartphoneBuilder
  VALID_OS = ['Android', 'iOS', 'Windows', 'Blackberry']

  def initialize
    @smartphone = Smartphone.new
  end
  
  def self.build
    builder = new
    yield(builder)
    builder.smartphone
  end

  def set_model(model)
    validate_presence!('Model', model)
    @smartphone.model = model
  end

  def set_os(os)
    validate_presence!('Operating system', os)
    validate_os!(os)
    @smartphone.os = os
  end

  def add_processor(speed)
    validate_presence!('Processor speed', speed)
    @smartphone.processor = CPU.new(speed)
  end

  def add_ram(size)
    validate_presence!('RAM size', size)
    @smartphone.ram = RAM.new(size)
  end

  def add_memory(size)
    validate_presence!('Memory', size)
    @smartphone.memory = size
  end

  def add_touchscreen(size)
    validate_presence!('Screen size', size)
    @smartphone.touchscreen = Touchscreen.new(size)
  end

  def smartphone
    obj = @smartphone.dup
    @smartphone = Smartphone.new
    obj
  end

  private

  def validate_presence!(attribute, value)
    raise "#{attribute} is required" if value.nil?
  end

  def validate_os!(os)
    raise "Operating system unknown" unless VALID_OS.include?(os)
  end
end