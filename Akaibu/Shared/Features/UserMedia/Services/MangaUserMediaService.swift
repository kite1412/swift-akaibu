//
//  MangaUserMediaService.swift
//  Akaibu
//
//  Created by kite1412 on 06/01/26.
//

class MangaUserMediaService: UserMediaService {
    private let repository = DIContainer.shared.mangaRepository
    private let mapper = PaginatedResultMapper()
    
    func getUserMediaList(status: String?) async throws -> PaginatedResult<[UserMediaData]> {
        let res = try await repository.getUserMangaList(status: UserMangaStatusMapper.status(from: status))
        return mapper.mapResult(res)
    }
    
    func updateConsumedUnits(for media: UserMediaData, with consumedUnits: Int) async throws -> UserMediaData {
        media
    }
    
    func updateScore(for media: UserMediaData, with score: Int) async throws -> UserMediaData {
        media
    }
    
    func updateStatus(for media: UserMediaData, with status: String) async throws -> UserMediaData {
        media
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
