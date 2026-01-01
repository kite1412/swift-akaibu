//
//  PaginatedResult.swift
//  Akaibu
//
//  Created by kite1412 on 01/01/26.
//

typealias NextResultClosure<Item> = (() async throws -> PaginatedResult<Item>?)?

struct PaginatedResult<Item> {
    let data: Item
    let next: NextResultClosure<Item>
}
