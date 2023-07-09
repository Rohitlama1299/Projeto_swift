//
//  main.swift
//  Pokemon Actual final version
//
//  Created by Rohit Lama on 19/06/2023.
//

import Foundation

// Define the Pokemon class
class Pokemon {
    let name: String
    var health: Int
    let type: String
    var attacks: [String]
    var attackDamage: [Int]
    
    init(name: String, health: Int, type: String, attacks: [String], attackDamage: [Int]) {
        self.name = name
        self.health = health
        self.type = type
        self.attacks = attacks
        self.attackDamage = attackDamage
    }
    
    func attack(target: Pokemon, attackIndex: Int) {
            if health <= 0 {
                print("\(name) is unable to attack. It has fainted!")
                return
            }
            
            if attackIndex >= 0 && attackIndex < attacks.count && attackIndex < attackDamage.count {
                let attackName = attacks[attackIndex]
                print("\(name) attacks \(target.name) with \(attackName)!")
                let damage = attackDamage[attackIndex] // Get the damage value for the attack
                target.health -= damage
                print("\(target.name)'s health reduced to \(target.health)")
            } else {
                print("Invalid attack index.")
            }
        }
    }

// Function to randomly select a Pokemon from a given list
func chooseRandomPokemon(from pokemonList: [Pokemon]) -> Pokemon {
    let randomIndex = Int.random(in: 0..<pokemonList.count)
    return pokemonList[randomIndex]
}

// Create a list of available Pokemon
let availablePokemon = [
    Pokemon(name: "Pikachu", health: 100, type: "Electric", attacks: ["Thunderbolt", "Quick Attack", "Iron Tail", "Thunder Punch"], attackDamage: [10, 20, 30, 40]),
    Pokemon(name: "Charmander", health: 100, type: "Fire", attacks: ["Ember", "Scratch", "Fire Fang", "Flamethrower"], attackDamage: [10, 20, 30, 40]),
    Pokemon(name: "Squirtle", health: 100, type: "Water", attacks: ["Water Gun", "Bubble", "Aqua Tail", "Hydro Pump"], attackDamage: [10, 20, 30, 40]),
    Pokemon(name: "Bulbasaur", health: 100, type: "Grass", attacks: ["Vine Whip", "Tackle", "Razor Leaf", "Seed Bomb"], attackDamage: [10, 20, 30, 40]),
    Pokemon(name: "Metapod", health: 100, type: "Bug", attacks: ["Harden", "Tackle", "Bug Bite", "String Shot"], attackDamage: [10, 20, 30, 40]),
    Pokemon(name: "Arbok", health: 100, type: "Poison", attacks: ["Poison Jab", "Bite", "Acid Spray", "Gunk Shot"], attackDamage: [10, 20, 30, 40]),
    Pokemon(name: "Mewtwo", health: 100, type: "Psychic", attacks: ["Confusion", "Psychic", "Shadow Ball", "Psystrike"], attackDamage: [10, 20, 30, 40]),
    Pokemon(name: "Mew", health: 100, type: "Psychic", attacks: ["Pound", "Psychic", "Ancient Power", "Aura Sphere"], attackDamage: [10, 20, 30, 40]),
    Pokemon(name: "Sandslash", health: 100, type: "Ground", attacks: ["Scratch", "Earthquake", "Sand Attack", "Dig"], attackDamage: [10, 20, 30, 40]),
    Pokemon(name: "Arcanine", health: 100, type: "Fire", attacks: ["Bite", "Flamethrower", "Fire Fang", "Extreme Speed"], attackDamage: [10, 20, 30, 40]),
    Pokemon(name: "Minun", health: 100, type: "Electric", attacks: ["Nuzzle", "Thunderbolt", "Spark", "Thunder Punch"], attackDamage: [10, 20, 30, 40])
]

// Function to let a player choose their team of Pokemon
func chooseTeam() -> [Pokemon] {
    var team: [Pokemon] = []
    
    print("Choose your team of 6 Pokemon:")
    for i in 1...6 {
        print("Pokemon \(i):")
        for (index, pokemon) in availablePokemon.enumerated() {
            print("\(index + 1). \(pokemon.name)")
        }
        
        if let choice = readLine(), let pokemonIndex = Int(choice) {
            if pokemonIndex > 0 && pokemonIndex <= availablePokemon.count {
                let chosenPokemon = availablePokemon[pokemonIndex - 1]
                team.append(chosenPokemon)
                print("\n")
            } else {
                print("Invalid choice. Try again.")
            }
        }
    }
    
    return team
}

// Create the player's team
let playerTeam = chooseTeam()

// Create the computer's team (randomly chosen)
var computerTeam: [Pokemon] = []
for _ in 1...6 {
    let randomPokemon = chooseRandomPokemon(from: availablePokemon)
    computerTeam.append(randomPokemon)
}

// Function to simulate a battle between two teams
func battle(playerTeam: [Pokemon], computerTeam: [Pokemon]) {
    var currentPlayerPokemonIndex = 0
    var currentComputerPokemonIndex = 0
    
    while currentPlayerPokemonIndex < playerTeam.count && currentComputerPokemonIndex < computerTeam.count {
        let currentPlayerPokemon = playerTeam[currentPlayerPokemonIndex]
        let currentComputerPokemon = computerTeam[currentComputerPokemonIndex]
        
        print("\(currentPlayerPokemon.name)'s turn:")
        var validAttackChoice = false
        
        while !validAttackChoice {
            print("Choose an attack:")
            for (index, attack) in currentPlayerPokemon.attacks.enumerated() {
                print("\(index + 1). \(attack)")
            }
            
            if let choice = readLine(), let attackIndex = Int(choice) {
                if attackIndex > 0 && attackIndex <= currentPlayerPokemon.attacks.count {
                    let chosenAttackIndex = attackIndex - 1
                    currentPlayerPokemon.attack(target: currentComputerPokemon, attackIndex: chosenAttackIndex)
                    validAttackChoice = true
                    print("\n")
                } else {
                    print("Invalid attack choice. Try again.")
                }
            } else {
                print("Invalid input. Try again.")
            }
        }
        
        // Randomize computer's attack
        let computerAttackIndex = Int.random(in: 0..<currentComputerPokemon.attacks.count)
        currentComputerPokemon.attack(target: currentPlayerPokemon, attackIndex: computerAttackIndex)
        
        if currentPlayerPokemon.health <= 0 {
            print("\(currentPlayerPokemon.name) fainted!")
            currentPlayerPokemonIndex += 1
        }
        if currentComputerPokemon.health <= 0 {
            print("\(currentComputerPokemon.name) fainted!")
            currentComputerPokemonIndex += 1
        }
    }
    
    if currentPlayerPokemonIndex >= playerTeam.count {
        print("You lost the battle!")
    } else if currentComputerPokemonIndex >= computerTeam.count {
        print("You won the battle!")
    } else {
        print("The battle ended in a draw!")
    }
}



// Start the battle
battle(playerTeam: playerTeam, computerTeam: computerTeam)
