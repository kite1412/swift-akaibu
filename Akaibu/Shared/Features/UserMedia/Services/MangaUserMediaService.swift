//
//  MangaUserMediaService.swift
//  Akaibu
//
//  Created by kite1412 on 06/01/26.
//

import Foundation

class MangaUserMediaService: UserMediaService {
    private let repository = DIContainer.shared.mangaRepository
    private let mapper = PaginatedResultMapper()
    
    func getUserMediaList(status: String?, params: [String: String]?) async throws -> PaginatedResult<[UserMediaData]> {
        let res = try await repository.getUserMangaList(status: UserMangaStatusMapper.status(from: status), params: params)
        return mapper.mapResult(res)
    }
    
    func updateConsumedUnits(for media: UserMediaData, with consumedUnits: Int) async throws -> UserMediaData {
        if media.userStatus != UserMangaStatus.completed.rawValue {
            return try await updateUserMangaProgress(for: media, totalChaptersRead: consumedUnits)
        } else {
            return media
        }
    }
    
    func updateScore(for media: UserMediaData, with score: Int) async throws -> UserMediaData {
        try await updateUserMangaProgress(for: media, score: score)
    }
    
    func updateStatus(for media: UserMediaData, with status: String) async throws -> UserMediaData {
        try await updateUserMangaProgress(
            for: media,
            status: status,
            totalChaptersRead: status == UserMangaStatus.completed.rawValue ? media.totalUnits != nil ? media.totalUnits! : nil : nil
        )
    }
    
    private func updateUserMangaProgress(
        for media: UserMediaData,
        status: String? = nil,
        totalChaptersRead: Int? = nil,
        score: Int? = nil
    ) async throws -> UserMediaData {
        let res = try await repository.updateUserMangaProgress(
            mangaId: media.id,
            with: newProgress(
                media: media,
                status: status,
                totalChaptersRead: totalChaptersRead,
                score: score
            )
        )
        
        return media.applying { data in
            data.userStatus = status ?? data.userStatus
            data.consumedUnits = totalChaptersRead ?? data.consumedUnits
            data.userScore = score ?? data.userScore
            data.updatedAt = res.updatedAt
        }
    }
    
    private func newProgress(
        media: UserMediaData,
        status: String? = nil,
        totalChaptersRead: Int? = nil,
        score: Int? = nil
    ) -> UserMangaProgress {
        UserMangaProgress(
            status: UserMangaStatus(rawValue: status ?? media.userStatus)!,
            score: score ?? media.userScore,
            totalChaptersRead: totalChaptersRead ?? media.consumedUnits,
            updatedAt: Date()
        )
    }
    
    private class PaginatedResultMapper: PaginatedResultUserMediaMapper {
        func mapResult(_ result: PaginatedResult<[UserManga]>) -> PaginatedResult<[UserMediaData]> {
            PaginatedResult(
                data: result.data.map { manga in
                    manga.toUserMediaData()
                },
                next: { [weak self] in
                    if let res = try await result.next?() {
                        return self?.mapResult(res)
                    } else {
                        return nil
                    }
                }
            )
        }
    }
}
