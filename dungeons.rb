require 'pp'

class Dungeon
  attr_accessor :player

  def initialize(player_name)
    @player = Player.new(player_name)
    @rooms = []
  end

  def add_room(reference, name, description, connections)
    @rooms << Room.new(reference, name, description, connections)
  end

  def start(location)
    @player.location = location
    show_current_description
  end

  def go(direction)
    puts "You go #{direction.to_s}"

    @player.location = find_room_in_direction(direction)
    show_current_description
  end

  def show_current_description
    begin
      puts find_room_in_dungeon(@player.location).full_description
    rescue => e
      if (e.class == NoMethodError)
        puts "No room there bro."
      else
        puts "Error describing specified room"
      end

    end
  end

  def find_room_in_dungeon(reference)
    @rooms.detect { |room| room.reference == reference }
  end

  def find_room_in_direction(direction)
    find_room_in_dungeon(@player.location).connections[direction]
  end

  class Player
    attr_accessor :name, :location

    def initialize(player_name)
      @name = player_name
    end
  end

  class Room
    attr_accessor :reference, :name, :description, :connections

    def initialize(reference, name, description, connections)
      @reference = reference
      @name = name
      @description = description
      @connections = connections
    end

    def full_description
      "#{@name} \n\nYou are in #{@description}"
    end
  end
end

my_dungeon = Dungeon.new "Kevin Wahome"

my_dungeon.add_room(:largecave, "Large Cave", "a large cavernous cave", { :west => :smallcave })
my_dungeon.add_room(:smallcave, "Small Cave", "a small, claustrophobic cave", { :east => :largecave })

#start dungeon
my_dungeon.start(:largecave)
pp my_dungeon

#go west
my_dungeon.go(:west)
pp my_dungeon

#go east
my_dungeon.go(:east)
pp my_dungeon

#go to unknown direction
my_dungeon.go(:north)
