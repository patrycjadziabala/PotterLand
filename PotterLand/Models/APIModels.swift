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
    let starList: [StarListModel]
    let actorList: [PersonForTitleModel]
    let genreList: [GenreListModel]
    let imDbRating: String
    let imDbRatingVotes: String
    let boxOffice: BoxOfficeModel
}

extension TitleModel: SwipeableInformationTilePresentable {
    var titleLabel: String {
        title
    }
    
    var imageUrlString: String {
        image
    }
}

struct StarListModel: Codable {
    let id: String
    let name: String
}

struct PersonForTitleModel: Codable {
    let id: String
    let image: String
    let name: String
    let asCharacter: String
}

struct GenreListModel: Codable {
    let key: String
    let value: String
}

struct BoxOfficeModel: Codable {
    let budget: String
    let openingWeekendUSA: String
    let grossUSA: String
    let cumulativeWorldwideGross: String
}

struct HomeScreenTrailerModel: Codable {
    let imDbId: String
    let title: String
    let year: String
    let thumbnailUrl: String
    let link: String
    let linkEmbed: String
}

extension HomeScreenTrailerModel: SwipeableInformationTilePresentable {
    var id: String {
        imDbId
    }

    var titleLabel: String {
        title
    }

    var imageUrlString: String {
        thumbnailUrl
    }
}
