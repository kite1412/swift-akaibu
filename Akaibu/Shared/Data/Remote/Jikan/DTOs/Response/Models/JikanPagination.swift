//
//  JikanPagination.swift
//  Akaibu
//
//  Created by kite1412 on 20/02/26.
//

struct JikanPagination: Codable {
    let lastVisiblePage: Int
    let hasNextPage: Bool
    let currentPage: Int
    let items: JikanPaginationInfo
}
