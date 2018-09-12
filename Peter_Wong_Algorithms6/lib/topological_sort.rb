require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

# Khan's
def topological_sort(vertices)
  queue = []
  sorted = []
  in_edges = {}

  vertices.each do |vertex|
    queue.push(vertex) if vertex.in_edges.empty?
    in_edges[vertex] = vertex.in_edges.length
  end

  #not finished sorting as long as something is in queue.
  while !queue.empty?
    current = queue.shift
    sorted << current
    #go thru each out edges of current and delete those edges
    current.out_edges.each do |edge|
      if in_edges[edge.to_vertex] == 1
        queue.push(edge.to_vertex)
      end
      in_edges[edge.to_vertex] -= 1
    end
  end
  if sorted.length == vertices.length
    sorted
  else
    []
  end

  # sorted = []
  # top = []
  # vertices.each do |vertex|
  #   #put into queue any vertex with no in-edges
  #   if vertex.in_edges.empty?
  #     top.push(vertex)
  #   end
  # end
  #
  # until top.empty?
  #   current = top.pop
  #   sorted << current
  #   current.out_edges.each do |edge|
  #     edge.to_vertex.in_edges.delete(edge)
  #     if edge.to_vertex.in_edges.empty?
  #       top.push(edge.to_vertex)
  #     end
  #     # vertices.destroy!
  #     # vertices.delete(edge)
  #   end
  #   # vertices.destroy!
  #   vertices.delete(current)
  # end
  # # sorted
  # if vertices.length > 0
  #   return []
  # else
  #   return sorted
  # end
end


# # Tarjan's: need to fix from solutions
# def topological_sort(vertices)
#   sorted = []
#   explored = Set.new
#   this_stack = Set.new
#   cycle = false
#
#   vertices.each do |vertex|
#     cycle = dfs(vertex, explored, sorted, this_stack, cycle=false) if !explored.include?(vertex)
#     return [] if cycle
#   end
#
#   sorted
# end
#
# def dfs(vertex, explored, sorted, this_stack, cycle)
#   return true if this_stack.include?(vertex)
#   explored.add(vertex)
#   this_stack.add(vertex)
#
#   vertex.out_edges.each do |edge|
#     new_vertex = edge.to_vertex
#     if !explored.include?(new_vertex)
#       cycle = dfs(new_vertex, explored, sorted, this_stack)
#     end
#     return true if cycle
#   end
#
#   this_stack.delete(vertex)
#   sorted.unshift(vertex)
#   false
# end
