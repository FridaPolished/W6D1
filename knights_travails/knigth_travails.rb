require_relative "polytreenode"
require "byebug"

    MOVES = [
        [2, 1],
        [2, -1],
        [-2, 1],
        [-2, -1],
        [-1, 1],
        [-1, -1],
        [1, 1],
        [1, -1]
    ]

class KnightPathFinder

    attr_reader :pos, :past_positions, :root

    def initialize(origin_pos)
        @pos = origin_pos
        @root = PolyTreeNode.new(origin_pos)
        @considered_positions = [origin_pos]
        build_move_tree
    end

    def self.valid_moves(pos)
        result = []
        MOVES.each do |move|
            x, y = move
            col, row = pos
            if (col + x) >= 0 && (col + x) <= 7
                if (row + y) >= 0 && (row + y) <= 7
                    result << [col + x, y + row]
                end
            end
        end
        result
    end

    def build_move_tree
        debugger
        queue = [root]
        until queue.empty?
            cur = queue.shift
            cur_position = cur.value

            new_moves = new_move_positions(cur_position)
            new_moves.each do |ele|
                cur_node = PolyTreeNode.new(ele)
                cur.add_child(cur_node)
                queue << cur_node
            end
        end
    end


    def new_move_positions(pos)
        moves = KnightPathFinder.valid_moves(pos)

        selected_moves = moves.reject {|ele| @considered_positions.include?(ele)}
        @considered_positions.concat(selected_moves)
        selected_moves
    end
end

knight = KnightPathFinder.new([0,0])