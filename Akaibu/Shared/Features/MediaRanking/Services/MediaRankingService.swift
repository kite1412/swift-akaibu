//
//  MediaRankingService.swift
//  Akaibu
//
//  Created by kite1412 on 22/02/26.
//

protocol MediaRankingService {
    func getMediaRanking() async throws -> PaginatedResult<[MediaRank]>
}
