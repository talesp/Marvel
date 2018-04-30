//
//  CharacterResource+Resource.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 21/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

extension CharacterResource: PagedResource {

    static private let pathURLString = "characters"
    private(set) static var baseURL: URL = MarvelAPIConfig.baseURL

    func get(for page: Int = 0) -> Resource<DataWrapperResource<CharacterResource>> {
        var components = URLComponents(url: CharacterResource.baseURL, resolvingAgainstBaseURL: true)

        components?.queryItems?.append(URLQueryItem(name: "page", value: "\(page)"))

        let url = components?.url?.appendingPathComponent(CharacterResource.pathURLString) !! "Something went wrong"
        return Resource(url: url)
    }

    func search(query: String) -> Resource<DataWrapperResource<CharacterResource>> {
        var components = URLComponents(url: CharacterResource.baseURL, resolvingAgainstBaseURL: true)

        components?.queryItems?.append(URLQueryItem(name: "query", value: query))

        let url = components?.url?.appendingPathComponent(CharacterResource.pathURLString) !! "Something went wrong"
        return Resource(url: url)
    }

    static func search(with id: Int) -> Resource<CharacterResource> {
        fatalError("Implement")
    }

    static func search(with text: String) -> Resource<CharacterResource> {
        fatalError("Implement")
    }

    public static func resource(for page: Int = 0) -> Resource<DataWrapperResource<CharacterResource>> {

        let components = URLComponents(url: MarvelAPIConfig.baseURL, resolvingAgainstBaseURL: true)

        let url = components?.url?.appendingPathComponent("characters") !! "Error appending path"

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return Resource(url: url, decoder: decoder)
    }

}
