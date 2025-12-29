//
//  MediaCard.swift
//  Akaibu
//
//  Created by kite1412 on 29/12/25.
//

import SwiftUI
import Kingfisher

struct MediaCard: View {
    let data: MediaCardData
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            ZStack {
                KFImage.url(data.coverImageURL)
                    .placeholder {
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .progressViewStyle(.circular)
                            .background(.gray.opacity(0.2))
                    }
                    .onFailureView {
                        Image(systemName: "rectangle.slash")
                            .font(.title)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(.thinMaterial)
                    }
                    .resizable()
                
                if data.isAdult {
                    otherInformationLabel(
                        for: "Adult",
                        color: .white,
                        backgroundColor: .red
                    )
                    .opacity(0.9)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(4)
                    .font(.caption2)
                }
            }
            .aspectRatio(2/3, contentMode: .fit)
            .frame(maxHeight: 160)
            .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(data.title)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .font(.title3)
                    .fontWeight(.bold)
                
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 8) {
                            score
                            scoringUsers
                        }
                        
                        genres
                    }
                    
                    if let desc = data.description {
                        Text(desc)
                            .font(.caption)
                            .lineLimit(2)
                            .truncationMode(.tail)
                    }
                }
                
                others
            }
            .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(8)
        .padding(.trailing, 16)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.primary, lineWidth: 2)
                .fill(.ultraThinMaterial)
        )
    }
    
    private var score: some View {
        HStack(spacing: 4) {
            Image(systemName: "star.fill")
                .foregroundStyle(.yellow)
            Text(data.score.map { String(format: "%.2f", $0) } ?? "N/A")
        }
        .font(.caption)
    }
    
    private var genres: some View {
        HStack(spacing: 8) {
            ForEach(Array(data.genres.prefix(3)), id: \.self) { genre in
                Text(genre)
            }
        }
        .font(.caption2)
        .foregroundStyle(.gray)
    }
    
    private var others: some View {
        HStack {
            otherInformationLabel(
                for: data.type,
                color: .blue,
                backgroundColor: .blue.opacity(0.3)
            )
            otherInformationLabel(
                for: data.status,
                color: .green,
                backgroundColor: .green.opacity(0.3)
            )
        }
        .font(.caption2)
    }
    
    @ViewBuilder
    private var scoringUsers: some View {
        if let total = data.scoringUsers {
            HStack(spacing: 2) {
                Image(systemName: "person.2.fill")
                    .foregroundStyle(.gray)
                
                Text("\(total)")
            }
            .foregroundStyle(.gray)
            .italic()
            .font(.caption2)
        }
    }

    private func otherInformationLabel(
        for text: String,
        color: Color,
        backgroundColor: Color
    ) -> some View {
        Text(text)
            .foregroundStyle(color)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(backgroundColor)
            )
    }
}

private var mock = MediaCardData(
    id: 1,
    title: "A very long long long Title",
    description: "A very long long long long long long long long long long long description of A Title",
    coverImageURL: URL.init(string: "https://picsum.photos/300/200"),
    isAdult: true,
    genres: ["Fantasy", "Slice Of Life", "Action"],
    score: 9.8,
    type: "A type",
    status: "Not Yet Aired",
    scoringUsers: 10000
)

private var minimum = MediaCardData(
    id: 2,
    title: "A Title",
    description: "A Description of A Title",
    coverImageURL: nil,
    isAdult: false,
    genres: [],
    score: nil,
    type: "A type",
    status: "A status",
    scoringUsers: nil
)

#Preview {
    VStack {
        ForEach([mock, minimum]) { data in
            MediaCard(data: data)
        }
    }
    .padding()
}
