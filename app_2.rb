require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts "
------------------------------------------------
|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |
|Le but du jeu est d'être le dernier survivant !|
-------------------------------------------------

Quel est ton prénom jeune entrepreneur ?"
print "> "
name = gets.chomp
human = HumanPlayer.new(name)

enemies = []
player1 = Player.new('Josiane')
player2 = Player.new('José')
enemies << player1
enemies << player2

while (player1.life_points > 0 || player2.life_points > 0) && human.life_points > 0
    puts "-------------------------------------------------"
    puts "Voici l'état de ton personnage :"
    puts human.show_state

    action = nil
    puts "Quelle action veux-tu effectuer ?
a - chercher une meilleure arme
s - chercher à se soigner
--- attaquer un joueur en vue : ---"
    enemies.each_with_index do |enemy, index|
        if enemy.life_points > 0
            puts "#{index} - #{enemies[index].show_state}"
        end
    end

    while 1 == 1
        print "> "
        action = gets.chomp

        puts ""

        if action == "a"
            human.search_weapon
            break
        elsif action == "s"
            human.search_health_pack
            break
        elsif action.to_i >= 0 && action.to_i < enemies.length
            human.attacks(enemies[action.to_i])
            break
        else
            puts "Je n'ai pas compris ton action..."
            puts "On recommence ? 🔁"
        end
    end

    puts ""
    puts "😱 Les autres joueurs t'attaquent ! 😱"
    puts ""
    enemies.each do |enemy|
        if enemy.life_points > 0
            enemy.attacks(human)
            puts ""
        end
    end
end

puts "😳 La partie est finie 😳"

if human.life_points <= 0
    puts "😰 Tu as perdu ! 😰"
else
    puts "🎉 Bravo ! Tu as gagné ! 🎉"
end