//
//  StackDestination.swift
//  Akaibu
//
//  Created by kite1412 on 03/01/26.
//

enum StackDestination: Hashable {
    case mediaSearchResults(searchTitle: String)
    case animeDetail(animeId: Int)
    case mangaDetail(mangaId: Int)
}
