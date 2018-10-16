class Plateau
    def boardc
        tab = []
        tab[0] = "  €    A    $    B    $    C    €  ".split('')
        tab[1] = "€€$£££££££££€£££££££££€£££££££££$€€".split('')
        tab[2] = "  €         $         $         €  ".split('')
        tab[3] = '  €         $         $         €  '.split('')
        tab[4] = "1 €         $         $         € 1".split('')
        tab[5] = '  €         $         $         €  '.split('')
        tab[6] = "  €         $         $         €  ".split('')
        tab[7] = "€€£$$$$$$$$$€$$$$$$$$$€$$$$$$$$$£€€".split('')
        tab[8] = "  €         $         $         €  ".split('')
        tab[9] = "  €         $         $         €  ".split('')
        tab[10] = "2 €         $         $         € 2".split('')
        tab[11] = "  €         $         $         €  ".split('')
        tab[12] = "  €         $         $         €  ".split('')
        tab[13] = "€€£$$$$$$$$$€$$$$$$$$$€$$$$$$$$$£€€".split('')
        tab[14] = "  €         $         $         €  ".split('')
        tab[15] = "  €         $         $         €  ".split('')
        tab[16] = "3 €         $         $         € 3".split('')
        tab[17] = "  €         $         $         €  ".split('')
        tab[18] = "  €         $         $         €  ".split('')
        tab[19] = "€€$£££££££££€£££££££££€£££££££££$€€".split('')
        tab[20] = "  €    A    $    B    $    C    €  ".split('')
        return tab
    end
end

class Board
    @@tab = []
    @@k = 0
    @@possibility = "1A","1B","1C","2A","2B","2C","3A","3B","3C"
    def initialize (tab)
        @@tab << tab
    end

    def verifi_game
        while @@possibility != nil
            i = gets.chomp
            j = 0
            @@possibility.length.times do
                if i.upcase == @@possibility[j]
                    @@possibility.delete_at(j)
                    return i.upcase
                    break
                end
                j += 1
            end
            puts "Cette entré n'est pas disponible"
            puts "Essaie encore"
        end
    end

    def remplace
        @jeu = verifi_game
        @@k = @@tab.length - 1
        tab = @@tab[@@k]
        i = 0
        j = 0
        if @jeu.split('')[1] == 'B'
            i = 10
        elsif @jeu.split('')[1] == 'C'
            i = 20
        else
            i = 0
        end

        if @jeu.split('')[0] == '2'
            j = 6
        elsif @jeu.split('')[0] == '3'
            j = 12
        else
            j = 0
        end

        if (@@tab.length) % 2 == 0
            tab[j + 3][i + 6] = '\\'
            tab[j + 3][i + 8] = '/'
            tab[j + 4][i + 5] = '*'
            tab[j + 4][i + 7] = 'X'
            tab[j + 4][i + 9] = '*'
            tab[j + 5][i + 8] = '\\'
            tab[j + 5][i + 6] = '/'
        else
            tab[j + 3][i + 6] = '/'
            tab[j + 3][i + 7] = '*'
            tab[j + 3][i + 8] = '\\'
            tab[j + 4][i + 5] = '{'
            tab[j + 4][i + 7] = 'O'
            tab[j + 4][i + 9] = '}'
            tab[j + 5][i + 6] = '\\'
            tab[j + 5][i + 7] = '*'
            tab[j + 5][i + 8] = '/'
        end

        @@tab << tab
        return tab
    end

    def to_sa
        plat = remplace
        plat.each do |v|
            puts v.join('')
        end
    end

    def victory
        tab = @@tab[@@k]

        if ((tab[4][7] + tab[10][7] + tab[16][7] == 'XXX') || (tab[4][17] + tab[10][17] + tab[16][17] == 'XXX') || (tab[4][27] + tab[10][27] + tab[16][27] == 'XXX') ||
            (tab[4][7] + tab[4][17] + tab[4][27] == 'XXX' ) || (tab[10][7] + tab[10][17] + tab[10][27] == 'XXX') || (tab[16][7] + tab[16][17] + tab[16][27] == 'XXX') ||
                (tab[4][7] + tab[10][17] + tab[16][27] == 'XXX') || (tab[4][27] + tab[10][17] + tab[16][7] == 'XXX'))
                return 0
        elsif  
        ((tab[4][7] + tab[10][7] + tab[16][7] == 'OOO') || (tab[4][17] + tab[10][17] + tab[16][17] == 'OOO') || (tab[4][27] + tab[10][27] + tab[16][27] == 'OOO') || 
                (tab[4][7] + tab[4][17] + tab[4][27] == 'OOO' ) || (tab[10][7] + tab[10][17] + tab[10][27] == 'OOO') || (tab[16][7] + tab[16][17] + tab[16][27] == 'OOO') ||
                (tab[4][7] + tab[10][17] + tab[16][27] == 'OOO') || (tab[4][27] + tab[10][17] + tab[16][7] == 'OOO'))
            return 1
        else
            return 2
        end
    end
end

class Player
    def initialize(s1,s2)
        @player1 = s1
        @player2 = s2
    end
    
    def player_name
    puts "#{@player1} joue avec les X"
    puts "#{@player2} joue avec les O"
    return @player1, @player2
    end
end

class Game
    def play
        p "Inscrivez le nom qui jouera avec les X"
        j1 = gets.chomp
        p "Le nom du 2eme joueur"
        j2 = gets.chomp
        @game1 = Player.new(j1, j2)
        @tab_des_nom = @game1.player_name
    end

    def turn
        manche0 = Plateau.new
        @plat = manche0.boardc
        @plat.each do |v|
            puts v.join('')
        end
        puts "#{@tab_des_nom[0]} commence la partie !"
    end

    def go
        i = 0
        game = Board.new(@plat)
        10.times do 
            if game.victory != 2
                puts "bravos " + @tab_des_nom[game.victory]
                break
            end
            game.to_sa
            if i >= 8 && game.victory == 2
                puts "Match nul."
                break
            end
            i += 1
        end
    end

end

while 1 < 2

game1 = Game.new
game1.play
game1.turn
game1.go

    
end
