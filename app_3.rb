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
puts "
Contre combien d'ennemies tu veux combattre ?"
print "> "
nb_enemies = gets.chomp.to_i
my_game = Game.new(name, nb_enemies)
puts "-------------------------------------------------"

while my_game.is_still_ongoing?
    my_game.show_players
    puts ""
    my_game.menu
    print "> "
    choice = gets.chomp
    puts ""
    my_game.menu_choice(choice)
    puts ""
    my_game.enemies_attack
    puts ""
    my_game.new_players_in_sight
    puts ""
end

my_game.end