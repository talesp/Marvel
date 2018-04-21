//
//  Webservice.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 19/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

enum Result<T, E: Error> {
    case success(T)
    case failure(E)

    init(_ value: T) {
        self = Result.success(value)
    }

    init(_ value: E) {
        self = Result.failure(value)
    }

}

enum NetworkError: Error {
    case invalidData
    case emptyData
    case redirection
    case serverError
    case unknowm
}

final class Webservice {

    let urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func load<T>(_ resource: Resource<T>,
                 decoder: JSONDecoder = JSONDecoder(),
                 completion: @escaping (Result<T, NetworkError>) -> Void) {

        let request = URLRequest(resource: resource)

        let task = urlSession.dataTask(with: request) { [unowned self] data, urlResponse, error in
            let result: Result<T, NetworkError>
            if let response = urlResponse as? HTTPURLResponse,
                let status = response.status {
                switch status.responseType {
                case .success:
                    result = self.parse(data, for: resource, error: error)
                case .redirection:
                    result = Result(.redirection)
                case .clientError:
                    fatalError("FIXME")
                case .serverError:
                    result = Result(.serverError)
                default:
                    result = Result(.unknowm)
                    fatalError("FIXME")
                }
            }
            else if let error = error {
                dump(error)
                fatalError("FIXME")
            }
            else {
                result = Result(.unknowm)
            }
            completion(result)
        }
        task.resume()
    }

    private func parse<T>(_ data: Data?,
                          for resource: Resource<T>,
                          error: Error?) -> Result<T, NetworkError> where T: Codable {
        let result: Result<T, NetworkError>
        if let data = data {
            do {
                result = try Result(resource.parse(data))
            }
            catch {
                result = Result(NetworkError.invalidData)
            }
        }
        else if let error = error {
            dump(error)
            fatalError("FIXME")

        }
        else {
            result = Result(NetworkError.emptyData)
        }
        return result
    }
}
