//
//  ApiObjects.swift
//  GoHeadlines
//
//  Created by Manogna podishetty on 12/3/19.
//  Copyright © 2019 Manogna podishetty. All rights reserved.
//

import Foundation


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topHeadlines = try? newJSONDecoder().decode(TopHeadlines.self, from: jsonData)

import Foundation

// MARK: - Sources
struct Sources: Codable {
    var status: String?
    var sources: [SourceElement]?
}

class  GenearlRes :Decodable{
    var result : String
    var errors : String
    init() {
        self.result = ""
        self.errors = ""
    }
}
// MARK: - TopHeadlines
struct NewStories: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    var source: Source?
    var author: String?
    var title, articleDescription: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: Date?
    var content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

// MARK: - Source
struct Source: Codable {
    var id: String?
    var name: String?
}

// MARK: - Source
struct SourceElement: Codable {
    var id, name, sourceDescription: String?
    var url: String?
//    var category: Category?
    var category,language, country: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case sourceDescription = "description"
        case url, category, language, country
    }
}

enum Category: String, Codable {
    case business = "business"
    case entertainment = "entertainment"
    case general = "general"
    case health = "health"
    case science = "science"
    case sports = "sports"
    case technology = "technology"
}

//2019-12-10T23:53:00Z
extension DateFormatter {
  static let iso8601Full: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
}
/**/
struct Settings {
    var country : Int
    var lang : Int
    var category : Int
    var sources : [String]
    var pagesize : Double
    var search : String
    var mode : Int
    var sort: Int
    init(){
        self.country = 51;
        self.category = 7;
        self.lang = 2;
        self.sources = [];
        self.pagesize = 30;
        self.search = "";
        self.mode = 0;
        self.sort = 2;
    }
}

