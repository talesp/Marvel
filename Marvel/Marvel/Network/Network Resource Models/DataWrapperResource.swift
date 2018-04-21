//
//  DataWrapperResource.swift
//  Marvel
//
//  Created by Tales Pinheiro De Andrade on 18/04/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

struct DataWrapperResource<T: Codable>: Codable {
    /// The HTTP status code of the returned result.
    let code: Int

    /// A string description of the call status.
    let status: String

    /// The copyright notice for the returned result.
    let copyright: String

    //swiftlint:disable line_length
    /// The attribution notice for this result.
    /// Please display either this notice or the contents of the attributionHTML field on all screens which contain data from the Marvel Comics API.
    let attributionText: String
    //swiftlint:enable line_length

    //swiftlint:disable line_length
    /// An HTML representation of the attribution notice for this result.
    /// Please display either this notice or the contents of the attributionText field on all screens which contain data from the Marvel Comics API.
    let attributionHTML: String
    //swiftlint:enable line_length

    /// The results returned by the call.
    let data: DataContainerResource<T>

    /// A digest value of the content returned by the call.
    let etag: String
}

