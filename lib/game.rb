class Game
    attr_accessor :human, :players_left, :enemies_in_sight

    def initialize (human_name, nb_players)
        @human = HumanPlayer.new(human_name)
        @players_left = nb_players
        @enemies_in_sight = []
        if nb_players >= 4
            4.times do |index|
                @enemies_in_sight << Player.new("Player#{index}")
            end
        else
            nb_players.times do |index|
                @enemies_in_sight << Player.new("Player#{index}")
            end
        end
        @players_left -= @enemies_in_sight.length
    end

    def kill_player(player)
        @enemies_in_sight.delete(player)
    end

    def is_still_ongoing?
        if ( @enemies_in_sight.any? { |enemy| enemy.life_points > 0 } || @players_left > 0 ) && @human.life_points > 0
            return true
        else
            return false
        end
    end

    def show_players
        @human.show_state
        puts "Il reste #{@enemies_in_sight.length} bots restants"
    end

    def menu
        puts "Quelle action veux-tu effectuer ?
a - chercher une meilleure arme
s - chercher à se soigner
--- attaquer un joueur en vue : ---"
        enemies_in_sight.each_with_index do |enemy, index|
            if enemy.life_points > 0
                puts "#{index} - #{enemies_in_sight[index].show_state}"
            end
        end
    end

    def menu_choice(choice)
        while true
            if choice == "a"
                human.search_weapon
                break
            elsif choice == "s"
                human.search_health_pack
                break
            elsif choice == "0" || (choice.to_i >= 1 && choice.to_i < enemies_in_sight.length)
                human.attacks(enemies_in_sight[choice.to_i])
                if enemies_in_sight[choice.to_i].life_points <= 0
                    kill_player(enemies_in_sight[choice.to_i])
                end
                break
            else
                puts "Je n'ai pas compris ton action..."
                puts "On recommence ? 🔁"
                print "> "
                choice = gets.chomp
            end
        end
    end

    def enemies_attack
        puts "😱 Les autres joueurs t'attaquent ! 😱"
        puts ""
        enemies_in_sight.each do |enemy|
            if enemy.life_points > 0 && human.life_points > 0
                enemy.attacks(human)
                puts ""
            end
        end
    end

    def end
        puts "😳 La partie est finie 😳"

        if human.life_points <= 0
            puts "😰 Tu as perdu ! 😰"
        else
            puts "🎉 Bravo ! Tu as gagné ! 🎉"
        end
    end

    def new_players_in_sight
        if @players_left > 0
            dice = rand(1..6)
            if dice == 1
                puts "Tu échappes aux nouveaux adversaires"
            elsif dice >= 2 && dice <= 4
                puts "Un nouvel adversaire arrive en vue !"
                @enemies_in_sight << Player.new("Player#{rand(4..9999)}")
                @players_left -= 1
            elsif dice == 6 || dice == 5
                puts "Deux joueurs arrivent en vue !"
                @enemies_in_sight << Player.new("Player#{rand(4..9999)}")
                @enemies_in_sight << Player.new("Player#{rand(4..9999)}")
                @players_left -= 2
            end
        end
    end
end