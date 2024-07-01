//
//  TMDBRequest.swift
//  URLSession
//
//  Created by J Oh on 6/26/24.
//

import Foundation
import Alamofire

// 네트워크 요청: Router Pattern 목적
// 인스턴스 초기화 불가 -> 저장 property X. 연산 property O
enum TMDBRequest {
    
    case trendingTV
    case trendingMovie
    case search(query: String) //
    case images(id: Int)
    
    // path parameter /tv/day
    var baseUrl: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var endPoint: URL {
        switch self {
        case .trendingTV:
            return URL(string: baseUrl + "trending/tv/day")!
        case .trendingMovie:
            return URL(string: baseUrl + "trending/movie/day")!
        case .search:
            return URL(string: baseUrl + "search/movie?query=해리포터")!
        case .images(let id): // 필요할 때 가져오면 됨
            return URL(string: baseUrl + "movie/\(id)/images")!
        }
    }
    
    var header: HTTPHeaders {
        return [ "Authorization": TrendAPI.key ]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        switch self {
        case .trendingTV, .trendingMovie:
            return ["language": "ko-KR"]
        case .search(let query):
            return ["query": query]
        case .images:
            return ["": ""]
        } 
    }
    
}
