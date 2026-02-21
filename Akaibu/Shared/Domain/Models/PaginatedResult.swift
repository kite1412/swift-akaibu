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
    
    func mapTo<T>(mapper: @escaping (Item) -> T) -> PaginatedResult<T> {
        let mapped = mapper(data)
        let next = next != nil ? {
            let res = try await self.next?()
            return res?.mapTo(mapper: mapper)
        } : nil
        
        return PaginatedResult<T>(
            data: mapped,
            next: next
        )
    }
}
