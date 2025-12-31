//
//  MALMangaDataSource.swift
//  Akaibu
//
//  Created by kite1412 on 31/12/25.
//

class MALMangaDataSource: MangaRemoteDataSource {
    private let client: MALHttpClient = .shared
    
    func fetchMangaRanks() async throws -> [MediaRank] {
        let req = client.createAuthenticatedRequest(
            path: MALPaths.mangaRanking,
            httpMethod: "GET",
            headers: nil,
            params: [
                "fields": MALMangaFields.rank
            ]
        )
        let res: MALMangaRanking = try await client.perform(req)
        
        return res.toMediaRanks()
    }
}
