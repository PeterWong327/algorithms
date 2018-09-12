# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to
require_relative 'topological_sort'
require_relative 'graph'

def install_order(arr)
  vertices = []
  max = 0
  #create the graph
  arr.each do |node|
    left = Vertex.new(node[0])
    right = Vertex.new(node[1])

    vertices.push(left) unless vertices.include?(left)
    vertices.push(right) unless vertices.include?(right)
    Edge.new(left, right)
    #reset max if needed
    max = node.max if node.max > max
  end

  # p vertices
  independent = []
  (1..max).each do |i|
    independent << i unless vertices[i]
  end

  # i = 1
  # while i < vertices.sort[-1]
  #   newVert = Vertex.new(i)
  #   vertices.push(Vertex.new(i)) if vertices.include?(newVert) == false
  #   i += 1
  # end

  #run topological sort on vertices
   result = topological_sort(vertices)

  #map vertices to get the values
  result.map do |result|
    result.value
  end
  independent + result
end
