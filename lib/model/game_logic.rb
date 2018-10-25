#
# require 'io/console'
#
# # Reads keypresses from the user including 2 and 3 escape character sequences.
# def read_char
#   STDIN.echo = false
#   STDIN.raw!
#
#   input = STDIN.getc.chr
#   if input == "\e" then
#     input << STDIN.read_nonblock(3) rescue nil
#     input << STDIN.read_nonblock(2) rescue nil
#   end
# ensure
#   STDIN.echo = true
#   STDIN.cooked!
#
#   return input
# end
#
# # oringal case statement from:
# # http://www.alecjacobson.com/weblog/?p=75
# def show_single_key
#   user_input = read_char
#
#   case user_input
#
#   when "\t"
#     exit 0
#   when "\e"
#     exit 0
#   when "\e[A"
#     puts "UP ARROW"
#   when "\e[B"
#     puts "DOWN ARROW"
#   when "\e[C"
#     puts "RIGHT ARROW"
#   when "\e[D"
#     puts "LEFT ARROW"
#   when "\u0003"
#     puts "CONTROL-C"
#     exit 0
#   end
#
# end
#
# show_single_key while(true)
