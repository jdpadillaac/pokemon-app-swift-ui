//
//  Home.swift
//  pokemonApp
//
//  Created by Jonatan Padilla on 13/06/23.
//

import SwiftUI

struct Home: View {
    
    @StateObject var pokemonViewModel = PokemonViewModel()
    
    private let adativeColumns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                LazyVGrid(columns: adativeColumns, spacing: 10) {
                    ForEach(pokemonViewModel.filteredPokemon, id: \.name ) { pokemon in
                        
                        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                            PokemonView(pokemon: pokemon)
                        }
                        
                    }
                }
                .animation(.easeIn, value: pokemonViewModel.filteredPokemon.count)
                .navigationTitle("Pokemon UI")
                .navigationBarTitleDisplayMode(.inline)
            }
            .searchable(text: $pokemonViewModel.searchText)
        }.environmentObject(pokemonViewModel)
    }
}

