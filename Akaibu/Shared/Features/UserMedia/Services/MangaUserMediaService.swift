//
//  MangaUserMediaService.swift
//  Akaibu
//
//  Created by kite1412 on 06/01/26.
//

import Foundation
import SwiftUI

class MangaUserMediaService: UserMediaService {
    @EnvironmentObject private var appRouter: AppRouter
    private let repository = DIContainer.shared.mangaRepository
    private let mapper = PaginatedResultMapper()
    
    func navigateToDetail(withId mediaId: Int, router: AppRouter) {
        router.goToMangaDetail(withId: mediaId)
    }
    
    func getUserMediaList(status: String?, params: [String: String]?) async throws -> PaginatedResult<[UserMediaData]> {
        let res = try await repository.getUserMangaList(status: UserMangaStatusMapper.status(from: status), params: params)
        return mapper.mapResult(res)
    }
    
    func updateProgress(for media: UserMediaData, with newProgress: UserMediaProgress) async throws -> UserMediaData {
        let res = try await repository.updateUserMangaProgress(
            mangaId: media.id,
            with: UserMangaProgress(
                status: UserMangaStatus(rawValue: newProgress.status)!,
                score: newProgress.score,
                totalChaptersRead: newProgress.consumedUnits,
                updatedAt: Date()
            )
        )
        
        return media.applying { data in
            data.userMediaProgress = res.toUserMediaProgress()
        }
    }
    
    private class PaginatedResultMapper: PaginatedResultUserMediaMapper {
        func mapResult(_ result: PaginatedResult<[UserManga]>) -> PaginatedResult<[UserMediaData]> {
            let next = result.next != nil ? { [weak self] in
                if let res = try await result.next?() {
                    return self?.mapResult(res)
                } else {
                    return nil
                }
            } : nil
            
            return PaginatedResult(
                data: result.data.map { manga in
                    manga.toUserMediaData()
                },
                next: next
            )
        }
    }
}
