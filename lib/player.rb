class Player 
    attr_accessor :name, :life_points
    def initialize(name)
        @name = name
        @life_points = 10
    end

    def show_state
        "#{@name} a #{@life_points.to_s} ❤️"
    end

    def gets_damage(quantity)
        if quantity.is_a? Integer
            @life_points -= quantity

            if @life_points <= 0
                puts "💔 Le joueur #{@name} a été tué ! 💔"
            end
        else
            raise ArgumentError.new("Expected an integer to deal damage")
        end
    end

    def attacks(player)
        puts "💥 " + @name + " attaque " + player.name
        damage = compute_damage
        puts "Il lui inflige #{damage} point#{damage > 1 ? "s" : ""} de dommage#{damage > 1 ? "s" : ""} 😡"
        player.gets_damage(damage)
    end

    private

    def compute_damage
        return rand(1..6)
    end
end

class HumanPlayer < Player
    attr_accessor :weapon_level

    def initialize(name)
        @name = name
        @life_points = 100
        @weapon_level = 1
    end

    def show_state
        puts "#{@name} a #{@life_points.to_s} ❤️  et une 🔫 de niveau #{@weapon_level}"
    end

    def search_weapon
        found_weapon_level = rand(1..6)

        puts "Tu as trouvé une arme de niveau #{found_weapon_level}"

        if found_weapon_level > @weapon_level
            puts "Youhou ! elle est meilleure que ton arme actuelle 😎 : tu la prends."
            @weapon_level = found_weapon_level
            puts "Ton arme actuel est donc de niveau #{@weapon_level}"
        else 
            puts "💩.. elle n'est pas mieux que ton arme actuelle 😢 ..."
        end
    end

    def search_health_pack
        dice = rand(1..6)

        if dice == 1
            puts "Tu n'as rien trouvé"
        elsif dice >= 2 || dice <= 5
            puts "Bravo, tu as trouvé un pack de +50 points de vie 💚 !"

            @life_points > 50 ? @life_points = 100 : @life_points += 50
        elsif dice == 6
            puts "Waow, tu as trouvé un pack de +80 points de vie 💜 !"

            @life_points > 20 ? @life_points = 100 : @life_points += 80
        end
    end

    private

    def compute_damage
        rand(1..6) * @weapon_level
    end
end