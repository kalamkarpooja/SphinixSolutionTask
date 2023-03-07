//
//  Population.swift
//  SphinixSolutionTask
//
//  Created by Mac on 06/03/23.
//

import Foundation
struct Population: Codable {
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let idNation, nation: String
    let idYear: Int
    let year: String
    let population: Int
    let slugNation: String

    enum CodingKeys: String, CodingKey {
        case idNation = "ID Nation"
        case nation = "Nation"
        case idYear = "ID Year"
        case year = "Year"
        case population = "Population"
        case slugNation = "Slug Nation"
    }
}
