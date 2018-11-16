class Smartphone
  attr_accessor :model, :os, :processor, :ram, :memory, :touchscreen

  def initialize(model = nil, os = nil, processor_speed = nil, ram_size = nil, memory_size = nil, screen_size = nil)
    @model = model
    @os = os
    @processor = CPU.new(processor_speed)
    @ram = RAM.new(ram_size)
    @memory = memory_size
    @touchscreen = Touchscreen.new(screen_size)
  end
end