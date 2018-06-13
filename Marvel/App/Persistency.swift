//
//  Persistency.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 12/06/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation
import os.log

struct Persistency {

    private var documentsURL: URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first !! "Problem reading documents directory"
        return url
    }

    func getFavoriteCharacters() -> [Character] {
        let url = documentsURL.appendingPathComponent("favorites.json")
        let decoder = JSONDecoder(dateDecodingStrategy: .iso8601)

        do {
            let data = try Data(contentsOf: url)
            let characters = try decoder.decode([Character].self, from: data)
            return characters
        }
        catch {
            if (error as NSError).code != 260 { // ignore file not created
                fatalError(error.localizedDescription) // TODO: maybe implement a better error handling
            }
            os_log("%{public}@", log: .default, type: .error, error.localizedDescription)
            return []
        }
    }

    func saveFavorite(characters: [Character]) {
        let url = documentsURL.appendingPathComponent("favorites.json")
        let encoder = JSONEncoder(dateEncodingStrategy: .iso8601)

        DispatchQueue.global(qos: .background).async {
            do {                
                let data = try encoder.encode(characters)
                try data.write(to: url)
                os_log("Saved", log: .default, type: .debug)
            }
            catch {
                fatalError(error.localizedDescription) // TODO: maybe implement a better error handling
            }
        }
    }

    func isFavorited(character: Character) -> Bool {
        guard let name = character.name else { return false }
        let favs = getFavoriteCharacters()
        if favs.contains(where: { $0.name == name }) {
            return true
        }

        return false
    }

    func toggleFavorite(for character: Character) {
        var favorites = getFavoriteCharacters()
        guard let name = character.name else { return }

        if let index = favorites.index(where: { $0.name == name }) {
            favorites.remove(at: index)
        }
        else {
            favorites.append(character)
        }

        Persistency().saveFavorite(characters: favorites)
    }
}
