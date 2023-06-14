//
//  PokemonView.swift
//  pokemonApp
//
//  Created by Jonatan Padilla on 13/06/23.
//

import SwiftUI

struct PokemonView: View {
    
    let pokemon: PokemonBasicInfo
    let dimension: Double = 140
    
    @EnvironmentObject var pokemonVm: PokemonViewModel
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonVm.getPokemonIndex(pokemon: pokemon)).png")) { image in

                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: dimension, height: dimension)
               
            } placeholder: {
                ProgressView()
                    .frame(width: dimension, height: dimension)
            }
            .background(.thinMaterial)
            .clipShape(Circle())
            
            
            Text("\(pokemon.name.capitalized)")
                .font(.system(size: 16, weight: .regular, design: .monospaced))
                .padding(.bottom, 20)
        }
    }
}
