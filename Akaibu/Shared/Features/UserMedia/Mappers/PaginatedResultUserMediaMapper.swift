//
//  PaginatedResultUserMediaMapper.swift
//  Akaibu
//
//  Created by kite1412 on 05/01/26.
//

protocol PaginatedResultUserMediaMapper {
    associatedtype Model
    
    func mapResult(_ result: PaginatedResult<[Model]>) -> PaginatedResult<[UserMediaData]>
}
