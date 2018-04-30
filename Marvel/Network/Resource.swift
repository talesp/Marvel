//
//  Resource.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 19/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

struct Resource<T: Decodable> {
    let url: URL
    let method: HttpMethod<Data>
    let parse: (Data) throws -> T
}

extension Resource {

    init(url: URL,
         method: HttpMethod<Any> = .get,
         decoder: JSONDecoder = JSONDecoder(),
         encoder: JSONEncoder = JSONEncoder()) {
        self.url = url
        self.method = method.map { json in
            try! JSONSerialization.data(withJSONObject: json, options: []) //swiftlint:disable:this force_try
        }
        self.parse = { data in
            return try decoder.decode(T.self, from: data)
        }
    }
}
