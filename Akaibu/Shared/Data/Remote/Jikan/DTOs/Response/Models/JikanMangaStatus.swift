//
//  JikanMangaStatus.swift
//  Akaibu
//
//  Created by kite1412 on 22/02/26.
//

enum JikanMangaStatus: String, Codable {
    case publishing = "Publishing", finished = "Finished", onHiatus = "On Hiatus", discontinued = "Discontinued", upcomging = "Upcoming"
    
    func toDomain() -> PublishingStatus {
        switch self {
        case .publishing: return .publishing
        case .finished: return .finished
        case .onHiatus: return .hiatus
        default: return .notYetPublished
        }
    }
}
