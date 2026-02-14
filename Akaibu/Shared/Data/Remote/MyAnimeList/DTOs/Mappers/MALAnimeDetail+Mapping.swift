//
//  MALAnimeDetail+Mapping.swift
//  Akaibu
//
//  Created by kite1412 on 14/02/26.
//

extension MALAnimeDetail {
    func toDomain() -> AnimeDetail {
        let startDate = startDate != nil ? DateFormatter.format(dateString: startDate!, with: .yearMonthDay) : nil
        let endDate = endDate != nil ? DateFormatter.format(dateString: endDate!, with: .yearMonthDay) : nil
        
        return AnimeDetail(
            id: id,
            title: title,
            synopsis: synopsis,
            type: mediaType.dislpayName(),
            coverImageURL: mainPicture.largeURLFirst(),
            rating: rating.toDomain(),
            airingStatus: status.toDomain(),
            genres: genres.toStrings(),
            score: mean.map(Double.init),
            scoringUsers: numScoringUsers,
            alternativeTitles: alternativeTitles.toStrings(),
            startDate: startDate,
            endDate: endDate,
            startSeason: startSeason.toString(),
            rank: rank,
            totalEpisodes: numEpisodes,
            userProgress: myListStatus?.toDomain(),
            broadcastDate: broadcast.localizedDateString,
            averageEpisodeDuration: averageEpisodeDuration,
            studios: studios.toStrings(),
            relatedAnime: relatedAnime.toDomain()
        )
    }
}
