//
//  APIModels.swift
//  PotterLand
//
//  Created by Patka on 22/05/2023.
//

import Foundation

struct TitleModel: Codable {
    let id: String
    let title: String
    let type: String
    let year: String
    let image: String
    let releaseDate: String
    let plot: String
    let awards: String
    let directors: String
    let stars: String
    let starList: [StarList]
    let actorsList: [PersonForTitleModel]
    let genreList: [GenreList]
    let imDbRating: String
    let imDbRatingVotes: String
    let boxOffice: BoxOffice
}

struct StarList: Codable {
    let id: String
    let name: String
}

struct PersonForTitleModel: Codable {
    let id: String
    let image: String
    let name: String
    let asCharacter: String
}

struct GenreList: Codable {
    let key: String
    let value: String
}

struct BoxOffice: Codable {
    let budget: String
    let openingWeekendUSA: String
    let grossUSA: String
    let cumulativeWorldwideGross: String
}
