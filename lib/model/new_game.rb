require "pry"
require "colorize"
require 'io/console'
require 'timers'




      def get_random_keys(given_user_id)
        keys = {"\e[A" => "Up Arrow", "\e[B" => "Down Arrow", "\e[C" => "Right Arrow", "\e[D" => "Left Arrow", "a"=>"a", "f"=>"f", "b"=>"b", "c"=>"c",
        "d"=>"d", "e"=>"e", "g"=>"g", "h"=>"h", "i"=>"i", "j"=>"j", "k"=>"k", "l"=>"l", "m"=>"m", "n"=>"n", "o"=>"o",
        "p"=>"p", "q"=>"q", "r"=>"r", "s"=>"s", "t"=>"t", "u"=>"u", "v"=>"v", "w"=>"w", "x"=>"x", "y"=>"y", "z"=>"z" }
        arr_keys = keys.keys
        temp = arr_keys.sample
        puts "#{("\n"*rand(5..45))}  #{("\t"*rand(1..20))} Press: #{keys[temp]}".colorize(change_user_color(given_user_id)).bold
        temp
      end

      def starting_counter
        pid = fork{ exec 'afplay', "lib/model/music/Power_up.mp3" }
        sleep(3)
        pid = fork{ exec 'afplay', "lib/model/music/Time_Trial_Start.mp3" }
      3.downto(0) do |i|
        if i == 0
          puts 'Go Go Go..........'.colorize(:green).bold
        elsif i == 1
          puts "#{i} second left!!!!".colorize(:yellow).bold
        else
          puts "#{i} seconds left".colorize(:yellow).bold
        end
          sleep 1
          puts `clear`
       end
       fork{ exec 'afplay', "lib/model/music/Underground.mp3" }
      end

      def read_char
          STDIN.echo = false
          STDIN.raw!
          input = STDIN.getc.chr
        if input == "\e" then
          input << STDIN.read_nonblock(3) rescue nil
          input << STDIN.read_nonblock(2) rescue nil
        end
        ensure
          STDIN.echo = true
          STDIN.cooked!
        return input
      end

      def change_user_color(given_user_id)
        Runner.all.find(given_user_id).color.downcase.to_sym
      end

      def key_check(given_level_id,given_user_id)
        counter=0
        starting_counter
        old_time = Time.now
        loop do
        puts "Current High Score: #{Score.all.select{|t| t.level_id == given_level_id}.map{|s| s.scores}.max}".bold
        current_time = Time.now
        temp = get_random_keys(given_user_id)
        user_input = read_char
        system "clear"
        counter += 1 if user_input == temp
        if ((current_time-old_time)) > 10
          pid = fork{ exec 'killall afplay' }
          break
        end
        end
        puts "______TIMES UP_______You Scored #{counter} Points".red.on_yellow.blink
        counter
      end

      def end_game_music
        pid = fork{ exec 'afplay',"lib/model/music/Game_Over.mp3" }
      end

      def brand_new_user(user_name)
        system "clear"
        prompt = TTY::Prompt.new
        puts "Hi, #{user_name} Welcome!"
        given_color = prompt.select("Choose your Team Color?", %w(Red Yellow Green Blue))
        given_destination = prompt.select("Choose your destination?", %w(Canada Jamaica China Brazil Russia))
        user = Runner.create(user_name: user_name,color: given_color,rank: "No Medals Yet")
        get_level = Level.find_by(level_name: given_destination)
        get_level.total_plays += 1
        get_level.save
        system "clear"
        fork{ exec 'killall afplay' }
        fork{ exec 'afplay',"lib/model/music/07_Invincible.mp3" }
        score = key_check(get_level.id,user.id)
        update_score(user.id, get_level.id, score)
        end_game_music
        easter_egg(user.id)
        sleep(5)
        system "clear"
        user_name
      end

      def choose_destination(user_name)
        prompt = TTY::Prompt.new
        puts "Hi, #{user_name} Welcome Back!".bold
        given_destination = prompt.select("Choose your destination?", %w(Canada Jamaica China Brazil Russia))
        get_level = Level.find_by(level_name: given_destination)
        get_level
      end

      def start_playing(runner_id, level_id)
        prompt = TTY::Prompt.new
      case prompt.select("Would You Like To Play?", %w(Yes No))
      when "Yes"
        pid = fork{ exec 'killall afplay' }
        pid = fork{ exec 'afplay',"lib/model/music/07_Invincible.mp3" }
        system "clear"
        score = key_check(level_id,runner_id)
        update_score(runner_id, level_id,score)
        end_game_music
        easter_egg(runner_id)
        sleep(5)
        system "clear"
      when "No"
        easter_egg(runner_id)
        sleep(2)
        system "clear"
        end
      end

      def get_high_scores
        system "clear"
        id_arr = Level.all.select{|t| t.id}.map{|d| d.id}
        id_arr.map do |each_level|
        puts "For Level: #{Level.all.find_by(id: each_level).level_name} the high score is #{Score.all.select {|t| t.level_id == each_level}.max.scores} by #{find_high_scoring_player(each_level)}".colorize(:green).bold
        puts "\n"
        end
      end

      def find_high_scoring_player(given_number)
        user_name = Score.all.select{|t| t.level_id == given_number}.map{|s| s}.sort_by{|w| w.scores}.last
        Runner.all.find_by(id: user_name.runner_id).user_name
      end




      def get_high_scores_for_me(person, level)
        one_runner=Score.all.select{|each_item| each_item.runner_id == person && each_item.level_id == level}.map { |each_score| each_score.scores }.max
      end

      def update_score(given_runner_id, given_level_id, given_score)
        Score.create(runner_id: given_runner_id, level_id: given_level_id, scores: given_score)
      end

      def welcome
        fork{ exec 'afplay', "lib/model/music/Invincible.mp3" }
        prompt = TTY::Prompt.new
        choices = %w(Start Exit Top_Scores)
        prompt.enum_select("What Would You Like To Do?", choices)
      end

      def get_user_name
        puts "What's Your Name?".bold
        user_name = gets.chomp.downcase.capitalize
        user_name
      end

      def is_user(user_name)
        user_name = gets.chomp.downcase.capitalize
        find_runner = Runner.find_by(user_name: user_name)
      end

      def easter_egg(given_user_id)
        my_color = change_user_color(given_user_id)
        puts "                                                            Sexy?Sex".colorize(my_color).bold
        puts "                                                           ?Sexy?Sexy".colorize(my_color).bold
        puts "                                                          y?Sexy?Sexy?".colorize(my_color).bold
        puts "                                                         ?Sexy?Sexy?S".colorize(my_color).bold
        puts "                                                         ?Sexy?Sexy?S".colorize(my_color).bold
        puts "                                                         ?Sexy?Sexy?Se".colorize(my_color).bold
        puts "                                                        ?Sexy?Sexy?Se".colorize(my_color).bold
        puts "                                                        ?Sexy?Sexy?Se".colorize(my_color).bold
        puts "                                                        ?Sexy?Sexy?Sexy?".colorize(my_color).bold
        puts "                                                       ?Sexy?Sexy?Sexy?Sexy".colorize(my_color).bold
        puts "                                                       ?Sexy?Sexy?Sexy?Sexy?Se".colorize(my_color).bold
        puts "                                                       ?Sexy?Sexy?Sexy?Sexy?Sex".colorize(my_color).bold
        puts "                                                        ?Sexy? ?Sexy?Sexy?Sex".colorize(my_color).bold
        puts "                                                          ?Sex   ?Sexy?Sexy?".colorize(my_color).bold
        puts "                                                          ?Sex    ?Sexy?Sexy".colorize(my_color).bold
        puts "                                                          ?Sex    ?Sexy?Sexy".colorize(my_color).bold
        puts "                                                           ?Sex   ?Sexy?Sexy".colorize(my_color).bold
        puts "                                                            ?Se   ?Sexy?Sex".colorize(my_color).bold
        puts "                                                             ?Se  Sexy?Sexy".colorize(my_color).bold
        puts "                                                              ?Sexy?Sexy?Sex".colorize(my_color).bold
        puts "                                                               Sexy?Sexy?Sex".colorize(my_color).bold
        puts "                                                               ?Sexy?Sexy?sex".colorize(my_color).bold
        puts "                                                              ?Sexy?Sexy?Sexy?Se".colorize(my_color).bold
        puts "                                                              ?Sexy?Sexy?Sexy?Sexy?".colorize(my_color).bold
        puts "                                                              ?Sexy?Sexy?Sexy?Sexy?Sexy".colorize(my_color).bold
        puts "                                                              ?Sexy?Sexy?Sexy?Sexy?Sexy?S".colorize(my_color).bold
        puts "                                                               ?Sexy?Sexy    ?Sexy?Sexy?se".colorize(my_color).bold
        puts "                                                                ?Sexy?Se      ?Sexy?Sexy?".colorize(my_color).bold
        puts "                                                                ?Sexy?Se     ?Sexy?Sexy?".colorize(my_color).bold
        puts "                                                                ?Sexy?S    ?Sexy?Sexy".colorize(my_color).bold
        puts "                                                                ?Sexy?S_?Sexy?Sexy".colorize(my_color).bold
        puts "                                                               ?Sexy?Sexy?Sexy".colorize(my_color).bold
        puts "                                                               ?Sexy?Sexy?S".colorize(my_color).bold
        puts "                                                               ?Sexy?Sexy".colorize(my_color).bold
        puts "                                                              ?Sexy?Se".colorize(my_color).bold
        puts "                                                              ?Sexy?".colorize(my_color).bold
        puts "                                                              ?Sexy?".colorize(my_color).bold
        puts "                                                             ?Sexy?".colorize(my_color).bold
        puts "                                                             ?Sexy?".colorize(my_color).bold
        puts "                                                             ?Sexy".colorize(my_color).bold
        puts "                                                             ?Sexy".colorize(my_color).bold
        puts "                                                              ?Sex".colorize(my_color).bold
        puts "                                                              ?Sex".colorize(my_color).bold
      end
