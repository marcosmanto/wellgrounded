class EventHandler
  def initialize
    @handlers = {}
  end

  def add_handler(event, &block)
    if block_given?
      @handlers[event] = block
    end
  end

  def method_missing(event, *args)
  	@handlers[event.to_s] ||= nil
  	# puts event.to_s
    if @handlers[event.to_s]
      @handlers[event.to_s].call(*args)
    end
  end
end