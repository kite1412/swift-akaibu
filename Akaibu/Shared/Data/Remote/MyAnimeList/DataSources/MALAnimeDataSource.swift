//
//  MALAnimeDataSource.swift
//  Akaibu
//
//  Created by kite1412 on 30/12/25.
//

class MALAnimeDataSource: AnimeRemoteDataSource {
    private let client: MALHttpClient = .shared
    
    func fetchAnimeBases(title: String) async throws -> [AnimeBase] {
        let req = client.createAuthenticatedRequest(
            path: MALPaths.anime,
            httpMethod: "GET",
            headers: nil,
            params: [
                "q": title,
                "fields": MALAnimeFields.base
            ]
        )
        let res: MALAnimeList = try await client.perform(req)
        
        return res.toAnimeBases()
    }
    
    func fetchAnimeRanks() async throws -> [MediaRank] {
        let req = client.createAuthenticatedRequest(
            path: MALPaths.animeRanking,
            httpMethod: "GET",
            headers: nil,
            params: [
                "ranking_type": "all",
                "fields": MALAnimeFields.rank
            ]
        )
        let res: MALAnimeRanking = try await client.perform(req)
        
        return res.toMediaRanks()
    }
}
