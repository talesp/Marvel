//
//  MarvelAPIConfig.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 20/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

struct MarvelAPIConfig {

    /// FIXME: Use the following command to ignore local changes to this file.
    /// FIXME: After that, change the values below for `privatekey` and `apikey` with your own.
    /// `git update-index --skip-worktree Marvel/Network/MarvelAPIConfig.swift`
    /// If, after that, you want to push any change, undo the command above with the command below
    /// `git update-index --no-skip-worktree Marvel/Network/MarvelAPIConfig.swift`
    static let privatekey = <#privatekey#>
    static let apikey = <#apikey#>
    static let timestamp = Date().timeIntervalSince1970.description
    static let hash = "\(timestamp)\(privatekey)\(apikey)".md5()

    static let baseURLString = "https://gateway.marvel.com/v1/public/?" +
        "apikey=\(MarvelAPIConfig.apikey)&" +
        "ts=\(MarvelAPIConfig.timestamp)&" +
        "hash=\(MarvelAPIConfig.hash)"
    static let baseURL = URL(string: MarvelAPIConfig.baseURLString) !! "Verify the address for base URL"
}
