class Graph
  def initialize
    @nodes = {}
  end
  
  def add_node(node)
    @nodes[node] = []
  end
  
  def add_edge(node1, node2)
    @nodes[node1] << node2
  end
  
  def links
    @nodes
  end
end

class Knight
  BOARD_RANGE = [0, 1, 2, 3, 4, 5, 6, 7]
  @@positions = []
  BOARD_RANGE.repeated_permutation(2) {|permu| @@positions.push(permu) }
  KNIGHT_MOVES = [[1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-1, 2], [-2, 1]]

  def initialize
    @graph = Graph.new
  end

  def make_route(curr, dest)
    latest_pos = []
    curr.each do |arr|
      @graph.add_node(arr)
      KNIGHT_MOVES.each do |el|
        return if latest_pos.include?(dest)
        pos = [(el[0] + arr[0]), (el[1] + arr[1])]
        if @@positions.include?(pos)
          latest_pos.push(pos) 
          @graph.add_edge(arr, pos)
        end
      end
    end
    unless latest_pos.include?(dest)
      make_route(latest_pos, dest)
    end
  end

  def rec_arr(curr, arr, path, i = 1)
    path << curr
    unless arr[i].nil?
      return arr[i][1].include?(curr) ? rec_arr(arr[i][0], arr, path, i += 1) : rec_arr(curr, arr, path, i += 1)
    end
  end

  def knight_moves(initial_pos, end_pos)
    make_route([initial_pos], end_pos) 
    @graph.add_node(end_pos)
    @nodes = @graph.links
    arr = @nodes.to_a.reverse
    path = []
    rec_arr(end_pos, arr, path)
    path.uniq.reverse!
  end
end

knight = Knight.new

p knight.knight_moves([7, 7], [5, 3])
