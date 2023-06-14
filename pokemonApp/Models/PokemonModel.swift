//
//  PokemonModel.swift
//  pokemonApp
//
//  Created by Jonatan Padilla on 13/06/23.
//

import Foundation

struct PokemonBasicInfo:Codable{
    let name: String
    let url: String
    
    static var samplePokemon = PokemonBasicInfo(name: "Bulbasur", url: "https://pokeapi.co/api/v2/pokemon/13/")
}


struct PokemonDetail: Codable {
    let id: Int
    let height: Int
    let weight: Int
}
