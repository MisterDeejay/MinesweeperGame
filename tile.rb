class Tile
  ADJACENT = [
    [1, 1],
    [1, 0],
    [1, -1],
    [0, 1],
    [0, -1],
    [-1, 1],
    [-1,0],
    [-1,-1]
  ]

  attr_accessor :status
  attr_reader :display

  def initialize(board, pos)
    @board = board
    @pos = pos
    @status = 0
    @revealed = false
    @flagged = false
  end

  def set(status)
    @status = status
  end

  def display
    return 'F' if @flagged
    if @revealed
      if @status == 0
        return '_'
      elsif @status.is_a?(Integer)
        return @status.to_s
      else
        return 'X'
      end
    end
    '*'
  end

  def neighbors
    arr = []
    ADJACENT.each do |pos|
      tile = @board[[@pos[0] + pos[0], @pos[1] + pos[1]]]
      arr << tile unless tile.nil?
    end
    arr
  end

  def revealed
    @revealed = true
  end

  def revealed?
    @revealed
  end

  def flag
    @flagged = true
  end
end
