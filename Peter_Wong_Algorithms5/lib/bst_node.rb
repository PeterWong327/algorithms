class BSTNode

  attr_reader :value
  attr_accessor :left, :right, :parent

  def initialize(value)
    @left = nil
    @right = nil
    @value = value
    @parent = nil
  end
end
