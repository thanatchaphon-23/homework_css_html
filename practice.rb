# create a new Class, User, that has the following attributes:
# - name
# - email
# - password
class User
    attr_accessor :name, :email, :password, :rooms
  
    def initialize(name, email, password)
      @name = name
      @email = email
      @password = password
      @rooms = []
    end
  
    def display_info
      puts "Name: #{@name}"
      puts "Email: #{@email}"
    end
  
    def verify_password(input_password)
      if input_password == @password
        puts "#{@name} : password is correct."
      else
        puts "#{@name} : Incorrect password."
      end
    end
  
    def enter_room(room)
      room.add_user(self)
      @rooms << room unless @rooms.include?(room)
      puts "#{@name} has entered the room: #{room.name}"
    end
  
    def send_message(room, content)
      if @rooms.include?(room)
        message = Message.new(self, room, content)
        room.broadcast(message)
      else
        puts "#{@name} is not in the room: #{room.name}"
      end
    end
  
    def acknowledge_message(room, message)
      puts "#{@name} acknowledges receiving message: '#{message.content}' in room #{room.name}"
    end
  end
# create a new Class, Room, that has the following attributes:
# - name
# - description
# - users
class Room
    attr_accessor :name, :description, :users
  
    def initialize(name, description)
      @name = name
      @description = description
      @users = []
    end
  
    def add_user(user)
      @users << user unless @users.include?(user)
    end
  
    def display_room_info
      puts "Room Name: #{@name}"
      puts "Description: #{@description}"
      puts "Users in room: #{@users.map(&:name).join(', ')}"
    end
  
    def broadcast(message)
      puts "#{message.user.name} sent a message in the room #{@name}:"
      puts "#{message.content}"
      @users.each do |user|
        user.acknowledge_message(self, message) unless user == message.user
      end
    end
  end

# create a new Class, Message, that has the following attributes:
# - user
# - room
# - content
class Message
    attr_accessor :user, :room, :content
  
    def initialize(user, room, content)
      @user = user
      @room = room
      @content = content
    end
  end
  
# add a method to user so, user can enter to a room
# user.enter_room(room)
user1 = User.new("Ice", "thanatchaphon.rang@bumail.net", "12345")
user2 = User.new("Post", "punn.titw@bumail.net", "2567")

user1.verify_password("12345")  
user2.verify_password("2567")

room = Room.new("AIE312", "A room for learning.")

user1.enter_room(room)
user2.enter_room(room)

room.display_room_info


# add a method to user so, user can send a message to a room
# user.send_message(room, message)
# user.ackowledge_message(room, message)

user1.send_message(room, "Hello everyone!")
user2.send_message(room, "Good morning!")

# add a method to a room, so it can broadcast a message to all users
# room.broadcast(message)