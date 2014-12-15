# Game calls Board methods; handle IO
# Board handles game logic, array of tiles

# Tile handles a single tile
require 'yaml'
require_relative './board'
require_relative './tile'

class Game

  def run
    @board = setup
    puts @board

    loop do
      status = take_input
      puts @board
      if status == false
        break
      end
    end

    # ask for input
    # => save
    # => quit
    # => flag
    # => reveal
    # victory
    # => save times
    # clean up?
  end

  def take_input

    loop do
      print "(s)ave, (q)uit, (f)lag or (r)eveal? "
      case gets.chomp
      when 's'
        print "Enter filename: "
        filename = gets.chomp
        yaml_minesweeper = YAML.dump(@board)
        File.open(filename+'.yml', 'w') { |f| f.puts(yaml_minesweeper) }
        break
      when 'q'
        return false
      when 'f'
        print 'coordinates? '
        pos = gets.chomp.gsub(' ', ',').split(',').map { |x| x.to_i }
        @board.flag(pos)
        break
      when 'r'
        print 'coordinates? '
        pos = gets.chomp.gsub(' ', ',').split(',').map { |x| x.to_i }
        next if pos.length < 2
        if @board.reveal(pos) == :lose
          puts "You lose"
          return false
        end
        break
      else
      end
    end

    if @board.is_won?
      # print time taken
      puts "A winner is you"
      return false
    end
  end

  def setup
    yaml_minesweeper = nil

    loop do
      print "[l]oad game or [N]ew game? "
      case gets.chomp
      when 'l'
        print "Enter filename: "
        filename = gets.chomp
        File.open(filename+'.yml') { |f| yaml_minesweeper = YAML::load(f) }
        break
      when 'n' || ''
        print "Enter the length of your board (9): "
        board_size = gets.chomp.to_i
        print "How many bombs do you want to place (18)? "
        num_bombs = gets.chomp.to_i
        board_size = nil if board_size < 2
        num_bombs = nil if num_bombs <= 0
        yaml_minesweeper = Board.new(board_size, num_bombs)
        # yaml_minesweeper = Board.new({
        #   board_size: board_size
        #   num_bombs: num_bombs
        # })
        yaml_minesweeper.seed
        break
      else
      end
    end

    yaml_minesweeper
  end
end

game = Game.new
game.run
