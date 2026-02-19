//
//  MALMangaDetail+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 18/02/26.
//

extension MALMangaDetail {
    func toDomain(characters: [Character]) -> MangaDetail {
        let startDate = startDate != nil ? DateFormatter.format(dateString: startDate!, with: .yearMonthDay) : nil
        let endDate = endDate != nil ? DateFormatter.format(dateString: endDate!, with: .yearMonthDay) : nil
        
        return MangaDetail(
            id: id,
            title: title,
            synopsis: synopsis,
            type: mediaType.dislpayName(),
            coverImageURL: mainPicture.largeURLFirst(),
            isAdult: nsfw?.isDangerous ?? false,
            publishingStatus: status.toDomain(),
            genres: genres.toStrings(),
            score: mean.map(Double.init),
            scoringUsers: numScoringUsers,
            alternativeTitles: alternativeTitles.toStrings(),
            startDate: startDate,
            endDate: endDate,
            rank: rank,
            totalChapters: numChapters,
            totalVolumes: numVolumes,
            authors: authors.toDomain(),
            userProgress: myListStatus?.toDomain(),
            relatedManga: relatedManga.toDomain(),
            recommendations: recommendations.toDomain(),
            characters: characters
        )
    }
}
