# undirected graph
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
  
  def links(node)
    @nodes[node]
  end
end

class Knight
  # coordinated of the board
  BOARD_RANGE = [0, 1, 2, 3, 4, 5, 6, 7]
  POSITIONS = []
  BOARD_RANGE.repeated_permutation(2) {|permu| POSITIONS.push(permu) }

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
  # if it is, we need to find the path from initial point to end point to print it *idk how*
  # if not, we recursivly call find_route with latest_pos as its argument
  # it will run to find the next possible destinations
  @@foo = 0
  def find_route(curr)
    latest_pos = []
    curr.each do |arr|
      @graph.add_node(arr)
      KNIGHT_MOVES.each do |el|
        pos = [(el[0] + arr[0]), (el[1] + arr[1])]
        latest_pos.push(pos) if POSITIONS.include?(pos)
        @graph.add_edge(arr, pos) if POSITIONS.include?(pos)
      end
    end
    while @@foo < 2
      @@foo += 1
      find_route(latest_pos)
    end
  end

  def links
    @graph
  end


  def knight_moves(initial_pos, end_pos)
    find_route([initial_pos])
  end
end

knight = Knight.new

knight.knight_moves([3, 3], [0, 0])

p knight.links