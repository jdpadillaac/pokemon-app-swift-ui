//
//  PokemonDetailView.swift
//  pokemonApp
//
//  Created by Jonatan Padilla on 13/06/23.
//

import SwiftUI

struct PokemonDetailView: View {
    
    let pokemon: PokemonBasicInfo
    
    @EnvironmentObject var pokemonVm: PokemonViewModel
    
    
    var body: some View {
        VStack {
            PokemonView(pokemon: pokemon)
            
            VStack(spacing: 10) {
                Text("**ID**: \(pokemonVm.pokemonDetail?.id ?? 0)")
                Text("**Weight**: \(pokemonVm.pokemonDetail?.weight ?? 0)")
                Text("**Height**: \(pokemonVm.pokemonDetail?.height ?? 0)")
            }
        }.onAppear{
            pokemonVm.getPokemon(pokemon: pokemon)
        }
    }
}
