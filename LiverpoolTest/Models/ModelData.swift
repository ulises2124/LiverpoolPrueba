//
//  ModelData.swift
//  LiverpoolTest
//
//  Created by Ulises Atonatiuh González Hernández on 14/10/20.
//

import Foundation
import UIKit

struct ModelCell {
    let titulo: String
    let precio: String
    let ubicacion: String
    let image: UIImage
}

// MARK: - Response
struct ResponseData: Codable {
    let status: Status?
    let pageType: String?
    let plpResults: PlpResults?
}


// MARK: - PlpResults
struct PlpResults: Codable {
    let label: String
    let plpState: PlpState
    let sortOptions: [SortOption]
    let refinementGroups: [RefinementGroup]
    let records: [Record]
    let navigation: Navigation
}

// MARK: - Navigation
struct Navigation: Codable {
    let ancester, current: [Ancester]
    let childs: [String?]
}

// MARK: - Ancester
struct Ancester: Codable {
    let label, categoryId: String
}

// MARK: - PlpState
struct PlpState: Codable {
    let categoryId, currentSortOption, currentFilters: String
    let firstRecNum, lastRecNum, recsPerPage, totalNumRecs: Double?
}

// MARK: - Record
struct Record: Codable {
    let productId, skuRepositoryId, productDisplayName, productType: String
    let productRatingCount, productAvgRating, listPrice, minimumListPrice: Double
    let maximumListPrice, promoPrice, minimumPromoPrice, maximumPromoPrice: Double
    let isHybrid: Bool
    let marketplaceSLMessage, marketplaceBTMessage: String?
    let isMarketPlace, isImportationProduct: Bool
    let brand, seller, category: String
    let smImage, lgImage, xlImage: String
    let groupType: String
    let plpFlags: [String?]
    let variantsColor: [VariantsColor]?
}

// MARK: - VariantsColor
struct VariantsColor: Codable {
    let colorName, colorHex, colorImageURL: String?
}

// MARK: - RefinementGroup
struct RefinementGroup: Codable {
    let name: String
    let refinement: [Refinement]
    let multiSelect: Bool
    let dimensionName: String
}

// MARK: - Refinement
struct Refinement: Codable {
    let count: Int
    let label, refinementId: String
    let categoryId: String?
    let selected: Bool
    let colorHex: String?
}

// MARK: - SortOption
struct SortOption: Codable {
    let sortBy, label: String
}

// MARK: - Status
struct Status: Codable {
    let status: String
    let statusCode: Int
}
