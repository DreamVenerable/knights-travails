# undirected graph
class Graph
  attr_accessor :nodes
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
  # coordinated of the board
  BOARD_RANGE = [0, 1, 2, 3, 4, 5, 6, 7]
  @@positions = []
  BOARD_RANGE.repeated_permutation(2) {|permu| @@positions.push(permu) }

  # [x,y] format of knights moves relative to its position
  KNIGHT_MOVES = [[1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-1, 2], [-2, 1]]

  def initialize
    @graph = Graph.new
  end

  # starts with the initial position when program starts
  # it loops to adds knight moves to get possible destination
  # adds it as a node and edge, edge is linked to curr 
  # so there are 2 loops, curr loop which houses found nodes
  # and KNIGHT_MOVES loop that finds the next nodes from curr node
  # after curr loop runs once, we should check if end position is there
  # if not, we recursivly call find_route with latest_pos as its argument till its found
  # if it is, we stop, then we need to find the path from initial point 
  # to end point to print it
  def find_route(curr, dest)
    latest_pos = []
    curr.each do |arr|
      @graph.add_node(arr)
      KNIGHT_MOVES.each do |el|
        # stops loop when dest is found
        return @graph if latest_pos.include?(dest)

        pos = [(el[0] + arr[0]), (el[1] + arr[1])]
        
        if @@positions.include?(pos)
          latest_pos.push(pos) 
          @graph.add_edge(arr, pos)
        end
      end
    end

    unless latest_pos.include?(dest)
      find_route(latest_pos, dest)
    end
  end

  def pathfinder(ini, end_pos)
    @graph.add_node(end_pos)
    @nodes = @graph.links

    arr = @nodes.to_a.reverse
    keys =  @nodes.keys.reverse
    path = []

    rec_arr(end_pos, arr, path)

    path.reverse!
    path.uniq!
    p path
  end

  def rec_arr(curr, arr, path, i = 1)
    path << curr

    unless arr[i].nil?
      return rec_arr(arr[i][0], arr, path, i += 1) if arr[i][1].include?(curr)
      return rec_arr(curr, arr, path, i += 1) unless arr[i][1].include?(curr)
    end
  end

  def knight_moves(initial_pos, end_pos)

    # checks if coordinates are valid
    if @@positions.include?(initial_pos) && @@positions.include?(end_pos)
      find_route([initial_pos], end_pos) 
    else
      puts 'Invalid coordinates'
    end

    # gets shortest path
    pathfinder(initial_pos, end_pos)
  end
end

knight = Knight.new

knight.knight_moves([7, 7], [0, 0])
