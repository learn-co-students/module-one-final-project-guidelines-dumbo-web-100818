# require "pry"
# require "colorize"
#
#
#
#       def get_random_keys
#         keys = {"\e[A" => "Up Arrow", "\e[B" => "Down Arrow", "\e[C" => "Right Arrow", "\e[D" => "Left Arrow", "a"=>"a", "f"=>"f", "b"=>"b", "c"=>"c",
#         "d"=>"d", "e"=>"e", "g"=>"g", "h"=>"h", "i"=>"i", "j"=>"j", "k"=>"k", "l"=>"l", "m"=>"m", "n"=>"n", "o"=>"o",
#         "p"=>"p", "q"=>"q", "r"=>"r", "s"=>"s", "t"=>"t", "u"=>"u", "v"=>"v", "w"=>"w", "x"=>"x", "y"=>"y", "z"=>"z" }
#         arr_keys = keys.keys
#         temp = arr_keys.sample
#         puts "Press: #{keys[temp]}".colorize(:yellow)
#         temp
#       end
#
#       def starting_counter
#         puts "Starting ...3".colorize(:green)
#         sleep(1)
#         puts "Starting ...2".colorize(:green)
#         sleep(1)
#         puts "Starting ...1".colorize(:green)
#         sleep(1)
#         puts "Go Go Go....".colorize(:green)
#       end
#
#       def key_check
#         counter=0
#         starting_counter
#         old_time = Time.now
#         loop do
#         current_time = Time.now
#         temp = get_random_keys
#         user_input = gets.chomp
#         system "clear"
#         counter += 1 if user_input == temp
#         break if ((current_time-old_time)+2) > 10
#         end
#         puts "______TIMES UP_______You Scored #{counter} Points".red.on_yellow.blink
#         counter
#       end
#
#       def starter
#         loop do
#           p "Press E to exit, S to start, T to get High Scores"
#           answer = gets.chomp.downcase
#           case answer
#           when "T", "t"
#             get_high_scores
#           when "exit", "e", "E", "Exit"
#             break
#           when "S", "s", "start"
#             puts "What's Your Name?"
#             user_name = gets.chomp.downcase.capitalize
#             find_runner = Runner.find_by(user_name: user_name)
#
#
#             if find_runner != nil
#               system "clear"
#               get_level = choose_destination(user_name)
#
#               if get_level != nil
#                 if (Score.all.select {|t| t.runner_id == find_runner.id && t.level_id == get_level.id} != nil)==false
#               puts "Press H to see your High Score or S to Skip"
#               new_answer = gets.chomp
#               case new_answer
#               when "H", "h"
#               get_personal_high_score(find_runner.id, get_level.id)
#               when "S", "s"
#               get_level.total_plays += 1
#               get_level.save
#               score = key_check
#               update_score(find_runner.id, get_level.id, score)
#               easter_egg
#
#
#
#             else
#             end
#             else
#
#               get_level=choose_destination(user_name)
#               get_level.total_plays += 1
#               get_level.save
#               score = key_check
#               update_score(find_runner.id, get_level.id, score)
#               easter_egg
#               end
#             end
#             else
#               brand_new_user(user_name)
#             end
#           end
#         end
#       end
#
#
#       def brand_new_user(user_name)
#         puts "Hi, #{user_name} Welcome!"
#         puts "What color is are you? Red or Blue"
#         given_color = gets.chomp.downcase.capitalize
#         puts "Choose your destination -- Canada, Jamaica, China, Brazil, or Russia"
#         given_destination = gets.chomp.downcase.capitalize
#         user = Runner.create(user_name: user_name,color: given_color,rank: "No Medals Yet")
#         get_level = Level.find_by(level_name: given_destination)
#         get_level.total_plays += 1
#         get_level.save
#         system "clear"
#         score = key_check
#         update_score(user.id, get_level.id, score)
#         easter_egg
#       end
#
#       def choose_destination(user_name)
#         puts "Hi, #{user_name} Welcome Back!"
#         puts "Choose your destination -- Canada, Jamaica, China, Brazil, or Russia"
#         given_destination = gets.chomp.downcase.capitalize
#         get_level = Level.find_by(level_name: given_destination)
#         get_level
#       end
#
#       def get_high_scores
#         system "clear"
#         id_arr = Level.all.select{|t| t.id}.map{|d| d.id}
#         id_arr.map do |each_level|
#           puts "For Level: #{Level.all.find_by(id: each_level).level_name} the high score is #{Score.all.select {|t| t.level_id == each_level}.max.scores}".colorize(:green)
#           puts "\n"
#         end
#       end
#
#       def get_personal_high_score(given_id,given_level_id)
#         puts " Your Personal High Scores are :#{Score.all.select {|t| t.runner_id == given_id && t.level_id == given_level_id}.max.scores}"
#         Score.all.select {|t| t.runner_id == given_id && t.level_id == given_level_id}
#       end
#
#       def null_destination(find_runner, get_level)
#       response = Score.all.select {|t| t.runner_id == find_runner.id && t.level_id == get_level.id}
#       response
#       end
#
#
#       def update_score(given_runner_id, given_level_id, given_score)
#         Score.create(runner_id: given_runner_id, level_id: given_level_id, scores: given_score)
#       end
#
#
#       def easter_egg
#         puts "_____Sexy?Sex".colorize(:green)
#         puts "____?Sexy?Sexy".colorize(:green)
#         puts "___y?Sexy?Sexy?".colorize(:green)
#         puts "___?Sexy?Sexy?S".colorize(:green)
#         puts "___?Sexy?Sexy?S".colorize(:green)
#         puts "__?Sexy?Sexy?Se".colorize(:green)
#         puts "_?Sexy?Sexy?Se".colorize(:green)
#         puts "_?Sexy?Sexy?Se".colorize(:green)
#         puts "_?Sexy?Sexy?Sexy?".colorize(:green)
#         puts "?Sexy?Sexy?Sexy?Sexy".colorize(:green)
#         puts "?Sexy?Sexy?Sexy?Sexy?Se".colorize(:green)
#         puts "?Sexy?Sexy?Sexy?Sexy?Sex".colorize(:green)
#         puts "_?Sexy?__?Sexy?Sexy?Sex".colorize(:green)
#         puts "___?Sex____?Sexy?Sexy?".colorize(:green)
#         puts "___?Sex_____?Sexy?Sexy".colorize(:green)
#         puts "___?Sex_____?Sexy?Sexy".colorize(:green)
#         puts "____?Sex____?Sexy?Sexy".colorize(:green)
#         puts "_____?Se____?Sexy?Sex".colorize(:green)
#         puts "______?Se__?Sexy?Sexy".colorize(:green)
#         puts "_______?Sexy?Sexy?Sex".colorize(:green)
#         puts "________?Sexy?Sexy?sex".colorize(:green)
#         puts "_______?Sexy?Sexy?Sexy?Se".colorize(:green)
#         puts "_______?Sexy?Sexy?Sexy?Sexy?".colorize(:green)
#         puts "_______?Sexy?Sexy?Sexy?Sexy?".colorize(:green)
#         puts "_______?Sexy?Sexy?Sexy?Sexy?".colorize(:green)
#         puts "________?Sexy?Sexy____?Sexy?".colorize(:green)
#         puts "_________?Sexy?Se_______?Sexy?".colorize(:green)
#         puts "_________?Sexy?Se_____?Sexy?".colorize(:green)
#         puts "_________?Sexy?S____?Sexy?Sexy".colorize(:green)
#         puts "_________?Sexy?S_?Sexy?Sexy".colorize(:green)
#         puts "________?Sexy?Sexy?Sexy".colorize(:green)
#         puts "________?Sexy?Sexy?S".colorize(:green)
#         puts "________?Sexy?Sexy".colorize(:green)
#         puts "_______?Sexy?Se".colorize(:green)
#         puts "_______?Sexy?".colorize(:green)
#         puts "______?Sexy?".colorize(:green)
#         puts "______?Sexy?".colorize(:green)
#         puts "______?Sexy?".colorize(:green)
#         puts "______?Sexy".colorize(:green)
#         puts "______?Sexy".colorize(:green)
#         puts "_______?Sex".colorize(:green)
#         puts "_______?Sex".colorize(:green)
#       end
      #
      # def walked_1
      #   puts "          _____Sexy?Sex".colorize(:green)
      #   puts "          ____?Sexy?Sexy".colorize(:green)
      #   puts "          ___y?Sexy?Sexy?".colorize(:green)
      #   puts "          ___?Sexy?Sexy?S".colorize(:green)
      #   puts "          ___?Sexy?Sexy?S".colorize(:green)
      #   puts "          __?Sexy?Sexy?Se".colorize(:green)
      #   puts "          _?Sexy?Sexy?Se".colorize(:green)
      #   puts "          _?Sexy?Sexy?Se".colorize(:green)
      #   puts "          _?Sexy?Sexy?Sexy?".colorize(:green)
      #   puts "          ?Sexy?Sexy?Sexy?Sexy".colorize(:green)
      #   puts "          ?Sexy?Sexy?Sexy?Sexy?Se".colorize(:green)
      #   puts "          ?Sexy?Sexy?Sexy?Sexy?Sex".colorize(:green)
      #   puts "          _?Sexy?__?Sexy?Sexy?Sex".colorize(:green)
      #   puts "          ___?Sex____?Sexy?Sexy?".colorize(:green)
      #   puts "          ___?Sex_____?Sexy?Sexy".colorize(:green)
      #   puts "          ___?Sex_____?Sexy?Sexy".colorize(:green)
      #   puts "          ____?Sex____?Sexy?Sexy".colorize(:green)
      #   puts "          _____?Se____?Sexy?Sex".colorize(:green)
      #   puts "          ______?Se__?Sexy?Sexy".colorize(:green)
      #   puts "          _______?Sexy?Sexy?Sex".colorize(:green)
      #   puts "          ________?Sexy?Sexy?sex".colorize(:green)
      #   puts "          _______?Sexy?Sexy?Sexy?Se".colorize(:green)
      #   puts "          _______?Sexy?Sexy?Sexy?Sexy?".colorize(:green)
      #   puts "          _______?Sexy?Sexy?Sexy?Sexy?".colorize(:green)
      #   puts "          _______?Sexy?Sexy?Sexy?Sexy?".colorize(:green)
      #   puts "          ________?Sexy?Sexy____?Sexy?".colorize(:green)
      #   puts "          _________?Sexy?Se_______?Sexy?".colorize(:green)
      #   puts "          _________?Sexy?Se_____?Sexy?".colorize(:green)
      #   puts "          _________?Sexy?S____?Sexy?Sexy".colorize(:green)
      #   puts "          _________?Sexy?S_?Sexy?Sexy".colorize(:green)
      #   puts "          ________?Sexy?Sexy?Sexy".colorize(:green)
      #   puts "          ________?Sexy?Sexy?S".colorize(:green)
      #   puts "          ________?Sexy?Sexy".colorize(:green)
      #   puts "          _______?Sexy?Se".colorize(:green)
      #   puts "          _______?Sexy?".colorize(:green)
      #   puts "          ______?Sexy?".colorize(:green)
      #   puts "          ______?Sexy?".colorize(:green)
      #   puts "          ______?Sexy?".colorize(:green)
      #   puts "          ______?Sexy".colorize(:green)
      #   puts "          ______?Sexy".colorize(:green)
      #   puts "          _______?Sex".colorize(:green)
      #   puts "          _______?Sex".colorize(:green)
      # end
      #
      # def walked_2
      #   puts "                                  _____Sexy?Sex".colorize(:green)
      #   puts "                                  ____?Sexy?Sexy".colorize(:green)
      #   puts "                                  ___y?Sexy?Sexy?".colorize(:green)
      #   puts "                                  ___?Sexy?Sexy?S".colorize(:green)
      #   puts "                                  ___?Sexy?Sexy?S".colorize(:green)
      #   puts "                                  __?Sexy?Sexy?Se".colorize(:green)
      #   puts "                                  _?Sexy?Sexy?Se".colorize(:green)
      #   puts "                                  _?Sexy?Sexy?Se".colorize(:green)
      #   puts "                                  _?Sexy?Sexy?Sexy?".colorize(:green)
      #   puts "                                  ?Sexy?Sexy?Sexy?Sexy".colorize(:green)
      #   puts "                                  ?Sexy?Sexy?Sexy?Sexy?Se".colorize(:green)
      #   puts "                                  ?Sexy?Sexy?Sexy?Sexy?Sex".colorize(:green)
      #   puts "                                  _?Sexy?__?Sexy?Sexy?Sex".colorize(:green)
      #   puts "                                  ___?Sex____?Sexy?Sexy?".colorize(:green)
      #   puts "                                  ___?Sex_____?Sexy?Sexy".colorize(:green)
      #   puts "                                  ___?Sex_____?Sexy?Sexy".colorize(:green)
      #   puts "                                  ____?Sex____?Sexy?Sexy".colorize(:green)
      #   puts "                                  _____?Se____?Sexy?Sex".colorize(:green)
      #   puts "                                  ______?Se__?Sexy?Sexy".colorize(:green)
      #   puts "                                  _______?Sexy?Sexy?Sex".colorize(:green)
      #   puts "                                  ________?Sexy?Sexy?sex".colorize(:green)
      #   puts "                                  _______?Sexy?Sexy?Sexy?Se".colorize(:green)
      #   puts "                                  _______?Sexy?Sexy?Sexy?Sexy?".colorize(:green)
      #   puts "                                  _______?Sexy?Sexy?Sexy?Sexy?".colorize(:green)
      #   puts "                                  _______?Sexy?Sexy?Sexy?Sexy?".colorize(:green)
      #   puts "                                  ________?Sexy?Sexy____?Sexy?".colorize(:green)
      #   puts "                                  _________?Sexy?Se_______?Sexy?".colorize(:green)
      #   puts "                                  _________?Sexy?Se_____?Sexy?".colorize(:green)
      #   puts "                                  _________?Sexy?S____?Sexy?Sexy".colorize(:green)
      #   puts "                                  _________?Sexy?S_?Sexy?Sexy".colorize(:green)
      #   puts "                                  ________?Sexy?Sexy?Sexy".colorize(:green)
      #   puts "                                  ________?Sexy?Sexy?S".colorize(:green)
      #   puts "                                  ________?Sexy?Sexy".colorize(:green)
      #   puts "                                  _______?Sexy?Se".colorize(:green)
      #   puts "                                  _______?Sexy?".colorize(:green)
      #   puts "                                  ______?Sexy?".colorize(:green)
      #   puts "                                  ______?Sexy?".colorize(:green)
      #   puts "                                  ______?Sexy?".colorize(:green)
      #   puts "                                  ______?Sexy".colorize(:green)
      #   puts "                                  ______?Sexy".colorize(:green)
      #   puts "                                  _______?Sex".colorize(:green)
      #   puts "                                  _______?Sex".colorize(:green)
      # end
