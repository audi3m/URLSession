//
//  API.swift
//  URLSession
//
//  Created by J Oh on 6/25/24.
//

import Foundation
import Alamofire

class TMDBApi {
    static let shared = TMDBApi()
    
    private init() { }
    
    typealias TrendingHandler = ([Trend]?, String?) -> Void
    
    func trending(api: TMDBRequest, completionHandler: @escaping TrendingHandler) { 
        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: TrendAPI.header).responseDecodable(of: TrendResponse.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value.results, nil)
            case .failure(let error):
                completionHandler(nil, "잠시 후 다시 시도해주세요")
                print(error)
            }
        }
    }
    
    func request<T: Decodable>(api: TMDBRequest, model: T.Type, completionHandler: @escaping (T?, Error?) -> Void) {
        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: TrendAPI.header).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value, nil)
            case .failure(let error):
                completionHandler(nil, .none)
                print(error)
            }
        }
    }
    
}

struct TrendResponse: Decodable {
    let page: Int
    let results: [Trend]
}

struct Trend: Decodable {
    let id: Int
    let title: String?
    let name: String?
    let release_date: String?
    let vote_average: Double?
    let genre_ids: [Int]?
    let poster_path: String
    
    var genre: String {
        let id = self.genre_ids?.first ?? 0
        return genres[id] ?? "UNKOWN"
    }
    
    var posterUrl: String {
        "\(TrendAPI.posterUrl)\(poster_path)"
    }
    
    var castUrl: String {
        "\(TrendAPI.castUrl)\(id)/credits"
    }
    
}

let genres: [Int: String] = [
    0: "UNKOWN",
    28: "Action",
    12: "Adventure",
    16: "Animation",
    35: "Comedy",
    80: "Crime",
    99: "Documentary",
    18: "Drama",
    10751: "Family",
    14: "Fantasy",
    36: "History",
    27: "Horror",
    10402: "Music",
    9648: "Mystery",
    10749: "Romance",
    878: "Science Fiction",
    10770: "TV Movie",
    53: "Thriller",
    10752: "War",
    37: "Western"
]

