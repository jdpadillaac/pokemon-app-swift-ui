//
//  Pokemon.swift
//  pokemonApp
//
//  Created by Jonatan Padilla on 13/06/23.
//

import Foundation

final class PokemonViewModel: ObservableObject {
    
    let appService = AppHttpService()
    
    @Published var pokemonList: [PokemonBasicInfo] = []
    @Published var pokemonDetail: PokemonDetail?
    @Published var showError: Bool = false
    @Published var searchText = ""
    
    var filteredPokemon: [PokemonBasicInfo] {
        return searchText == "" ? pokemonList : pokemonList.filter {
            $0.name.contains(searchText.lowercased())
        }
    }
    
    
    init() {
        getPokemonList()
    }
    
    func getPokemonList() -> Void {
        let result = appService.get(url: "https://pokeapi.co/api/v2/pokemon?limit=151")
        
        switch result {
        case .success(let dic):
        
            do {
                let json = try JSONSerialization.data(withJSONObject: dic["results"] as Any, options: [])
                let list = try JSONDecoder().decode([PokemonBasicInfo].self, from: json)
                
                pokemonList = list
            } catch let error  {
                showError = true
                print(error)
            }
            break
        case .failure(let err):
            print(err.err)
        }
    }
    
    func getPokemonIndex(pokemon: PokemonBasicInfo) -> Int {
        if let index = pokemonList.firstIndex(where: {$0.name == pokemon.name} ) {
            return index + 1
        }
        return 0
    }
    
    func getPokemon(pokemon: PokemonBasicInfo) -> Void {
        let id = getPokemonIndex(pokemon: pokemon)
        
        let result = appService.get(url: "https://pokeapi.co/api/v2/pokemon/\(id)/")
        
        switch result {
        case .success(let dic):
            guard let json = try? JSONSerialization.data(withJSONObject: dic , options: [] ) else {
                print("Error to decode detail")
                return
            }
            
            guard let detail = try? JSONDecoder().decode(PokemonDetail.self, from: json) else {
                print("Error in convert to struct")
                return
            }
            
            DispatchQueue.main.async {
                self.pokemonDetail = detail
            }
            
            break
        case.failure(let err):
            print("Failure \(err.localizedDescription)")
            break
        }
    }
    
}
