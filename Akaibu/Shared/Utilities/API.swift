//
//  API.swift
//  Akaibu
//
//  Created by kite1412 on 28/12/25.
//

import Foundation

struct API {
    static let jsonEncoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    static func encode<T: Encodable>(_ value: T) throws -> Data where T : Encodable {
        try jsonEncoder.encode(value)
    }
    
    static func decode<T: Decodable>(_ value: T.Type, from data: Data) throws -> T where T : Decodable {
        try jsonDecoder.decode(T.self, from: data)
    }
    
    private init() {}
}
