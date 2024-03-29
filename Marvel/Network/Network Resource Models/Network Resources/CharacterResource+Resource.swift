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

    static func resource(nameStartingWith name: String) -> Resource<DataWrapperResource<CharacterResource>> {
        var components = URLComponents(url: CharacterResource.baseURL, resolvingAgainstBaseURL: true)

        components?.queryItems?.append(URLQueryItem(name: "nameStartsWith", value: name))

        let url = components?.url?.appendingPathComponent(CharacterResource.pathURLString) !! "Something went wrong"
        return Resource(url: url)
    }

    public static func resource(for page: Int, pageSize: Int) -> Resource<DataWrapperResource<CharacterResource>> {

        var components = URLComponents(url: MarvelAPIConfig.baseURL, resolvingAgainstBaseURL: true)

        components?.queryItems?.append(URLQueryItem(name: "offset", value: "\(page * pageSize)"))
        components?.queryItems?.append(URLQueryItem(name: "limit", value: "\(pageSize)"))
        components?.queryItems?.append(URLQueryItem(name: "orderBy", value: "name"))
        
        let url = components?.url?.appendingPathComponent("characters") !! "Error appending path"

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return Resource(url: url, decoder: decoder)
    }

}
