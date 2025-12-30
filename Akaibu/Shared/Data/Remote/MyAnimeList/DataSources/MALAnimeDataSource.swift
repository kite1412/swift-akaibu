//
//  MALAnimeDataSource.swift
//  Akaibu
//
//  Created by kite1412 on 30/12/25.
//

class MALAnimeDataSource: AnimeRemoteDataSource {
    private let client: MALHttpClient = .shared
    
    func fetchAnimeBases(title: String) async throws -> [AnimeBase] {
        var req = client.createRequest(
            path: MALPaths.anime,
            httpMethod: "GET",
            headers: nil,
            params: [
                "q": title,
                "fields": MALAnimeFields.base
            ]
        )
        req.attachBearerToken()
        
        let res: MALAnimeList = try await client.get(req)
        
        return res.toAnimeBases()
    }
    
    func fetchAnimeRanks() async throws -> [MediaRank] {
        var req = client.createRequest(
            path: MALPaths.animeRanking,
            httpMethod: "GET",
            headers: nil,
            params: [
                "ranking_type": "all",
                "fields": MALAnimeFields.rank
            ]
        )
        req.attachBearerToken()
        
        let res: MALAnimeRanking = try await client.get(req)
        
        return res.toMediaRanks()
    }
}
