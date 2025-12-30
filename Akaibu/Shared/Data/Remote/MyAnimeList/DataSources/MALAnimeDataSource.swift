//
//  MALAnimeDataSource.swift
//  Akaibu
//
//  Created by kite1412 on 30/12/25.
//

class MALAnimeDataSource: AnimeRemoteDataSource {
    private let client: MALHttpClient = .shared
    
    func fetchAnimeRanks() async throws -> [MediaRank] {
        var req = client.createRequest(
            path: "anime/ranking",
            httpMethod: "GET",
            headers: nil,
            params: [
                "ranking_type": "all",
                "fields": "[mean,synopsis,media_type,status,rating]"
            ]
        )
        req.attachBearerToken()
        
        let res: MALAnimeRanking = try await client.get(req)
        
        return res.toMediaRanks()
    }
}
