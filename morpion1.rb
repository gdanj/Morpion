nom_v = []
i = 0
while i != 'n'
class Plateau 
    def boardc #renvois le plateau vide dans un tableau de tableau
        tab = []
        tab[0] = "  €    A    $    B    $    C    €  ".split('')
        tab[1] = "\033[34m€€$£££££££££€£££££££££€£££££££££$€€\033[0m".split('')
        tab[2] = "  €         $         $         €  ".split('')
        tab[3] = '  €         $         $         €  '.split('')
        tab[4] = "1 €         $         $         € 1".split('')
        tab[5] = '  €         $         $         €  '.split('')
        tab[6] = "  €         $         $         €  ".split('')
        tab[7] = "\033[34m€€£$$$$$$$$$€$$$$$$$$$€$$$$$$$$$£€€\033[0m".split('')
        tab[8] = "  €         $         $         €  ".split('')
        tab[9] = "  €         $         $         €  ".split('')
        tab[10] = "2 €         $         $         € 2".split('')
        tab[11] = "  €         $         $         €  ".split('')
        tab[12] = "  €         $         $         €  ".split('')
        tab[13] = "\033[34m€€£$$$$$$$$$€$$$$$$$$$€$$$$$$$$$£€€\033[0m".split('')
        tab[14] = "  €         $         $         €  ".split('')
        tab[15] = "  €         $         $         €  ".split('')
        tab[16] = "3 €         $         $         € 3".split('')
        tab[17] = "  €         $         $         €  ".split('')
        tab[18] = "  €         $         $         €  ".split('')
        tab[19] = "\033[34m€€$£££££££££€£££££££££€£££££££££$€€\033[0m".split('')
        tab[20] = "  €    A    $    B    $    C    €  ".split('')
        return tab
    end
end

class Board
    @@tab = []
    @@k = 0
    @@possibility = "1A","1B","1C","2A","2B","2C","3A","3B","3C" #tableau des possibilité
    def initialize (tab)
        @@tab << tab #récupair le plateau
    end

    def verifi_game #vérifi les entrées possibles
        while @@possibility != nil
            i = gets.chomp
            j = 0
            @@possibility.length.times do
                if i.upcase == @@possibility[j]
                    @@possibility.delete_at(j) #supprime le cases déjà utilisées
                    return i.upcase
                    break
                end
                j += 1
            end
            puts "Cette entrée n'est pas disponible"
            puts "Voici la liste des cases possibles"
            p @@possibility
            puts "Essaye encore"
        end
    end

    def remplace 
        @jeu = verifi_game #récupair la case choisie par le joueur, exemple 1A, 2B...
        @@k = @@tab.length - 1 # @@k est index un tableau, on récupère le index du dernier plateau
        tab = @@tab[@@k] 
        i = 0 #pour afficher X ou O dans la bonne case on utilise des variables j et i pour modifier les index.
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

        if (@@tab.length) % 2 == 0 # si la longeur du tableau de plateau est pair c'est le joueur 2 qui a jouer donc se sera la X
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

        @@tab << tab # on stocke les plateaux et on retourne le nouveau
        return tab
    end

    def to_sa #permet d'affiche le dernier jeu
        plat = remplace
        plat.each do |v|
            puts v.join('')
        end
    end

    def victory #on vérifie toute les possibilité de victoire 
        tab = @@tab[@@k]

        if ((tab[4][7] + tab[10][7] + tab[16][7] == 'XXX') || (tab[4][17] + tab[10][17] + tab[16][17] == 'XXX') || (tab[4][27] + tab[10][27] + tab[16][27] == 'XXX') ||
            (tab[4][7] + tab[4][17] + tab[4][27] == 'XXX' ) || (tab[10][7] + tab[10][17] + tab[10][27] == 'XXX') || (tab[16][7] + tab[16][17] + tab[16][27] == 'XXX') ||
                (tab[4][7] + tab[10][17] + tab[16][27] == 'XXX') || (tab[4][27] + tab[10][17] + tab[16][7] == 'XXX'))
                return 1
        elsif  
        ((tab[4][7] + tab[10][7] + tab[16][7] == 'OOO') || (tab[4][17] + tab[10][17] + tab[16][17] == 'OOO') || (tab[4][27] + tab[10][27] + tab[16][27] == 'OOO') || 
                (tab[4][7] + tab[4][17] + tab[4][27] == 'OOO' ) || (tab[10][7] + tab[10][17] + tab[10][27] == 'OOO') || (tab[16][7] + tab[16][17] + tab[16][27] == 'OOO') ||
                (tab[4][7] + tab[10][17] + tab[16][27] == 'OOO') || (tab[4][27] + tab[10][17] + tab[16][7] == 'OOO'))
            return 0
        else
            return 2
        end
    end
end

class Player #info joueur
    def play
        p "Inscrivez le nom du joueur qui jouera avec les O"
        @player1 = gets.chomp.capitalize
        p "inscrivez le nom du 2eme joueur"
        @player2  = gets.chomp.capitalize
    	return @player1, @player2 
    end

    def player_name
    puts "#{@player1} joue avec les O"
    puts "#{@player2} joue avec les X"
    end
end

class Game
	def play(nom = 0) #diffuse les info des joueurs
		if nom == 0
			pl = Player.new
			@tab_des_nom = pl.play
		else
			@tab_des_nom = nom
		end
	end

    def turn #affiche le plateau vide
        manche0 = Plateau.new
        @plat = manche0.boardc
        @plat.each do |v|
            puts v.join('')
        end
        puts "#{@tab_des_nom[0]} Commence la partie !"
    end

    def go 
        i = 0
        game = Board.new(@plat)
        10.times do #10 coups par seécu
            game.to_sa #affiche
            if i >= 8 && game.victory == 2 #condi macth nul
                puts "Match nul."
                break
            end
            if game.victory != 2 
                puts "bravos " + @tab_des_nom[game.victory]
                break
            end
            if i % 2 == 0
            	puts "#{@tab_des_nom[1]} c'est a ton tour de jouer"
            else 
            	puts "#{@tab_des_nom[0]} c'est a ton tour de jouer"
            end
            i += 1
        end
        return @tab_des_nom[game.victory] #return le non du gagnant.
    end

end
	
	partie1 = Game.new
	partie1.play
	partie1.turn
	nom_v << partie1.go #tableau des gagnants
	puts "historique des gagnants"
	p nom_v
	puts "La revanche ? o/n"
	i = gets.chomp
	if i == 'n' || i == 'N'
		break
	end
	puts "partie numero #{nom_v.length + 1}"
end