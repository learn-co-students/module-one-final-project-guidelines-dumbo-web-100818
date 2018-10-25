require_relative '../config/environment'

prompt = TTY::Prompt.new

loop do

welcome_result = welcome
case welcome_result

when  "Top_Scores"
  get_high_scores

when "Exit"
  system "clear"
  exit 0

when  "Start"

  user_name = prompt.ask('What is your name?') do |q|
  q.validate(/["a-zA-Z"]/, 'Invalid Name, re-enter your name')
  end
  
  find_runner = Runner.find_by(user_name: user_name)


  if find_runner == nil
    brand_new_user(user_name)

  else
    given_destination = choose_destination(user_name)
    case prompt.select("Would you like your Top Score?", %w(Yes No))

    when "Yes"

      if get_high_scores_for_me(find_runner.id, given_destination.id) == nil
        puts "You Don't Have a High Score "
        start_playing(find_runner.id, given_destination.id)

      else
        puts "Your High Score is: #{get_high_scores_for_me(find_runner.id, given_destination.id)}"
        start_playing(find_runner.id, given_destination.id)
      end

    when "No"
      start_playing(find_runner.id, given_destination.id)
   end

  end

 end

end
