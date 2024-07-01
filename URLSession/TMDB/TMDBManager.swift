//
//  TMDBManager.swift
//  URLSession
//
//  Created by J Oh on 6/26/24.
//

import Foundation

struct Lotto: Decodable {
    let drwNoDate: String
    let firstWinamnt: Int
}

enum LottoError: Int, Error {
    case failedRequest = 401
    case noData = 403
    case invalidResponse // 404
    case invalidData // 405
}

class TMDBManager {
    
    static let shared = TMDBManager()
    
    private init() { }
    
    func callRequest(completionHandler: @escaping (Lotto?, LottoError?) -> Void) {
        print(#function)
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1100")!
//        let request = URLRequest(url: url, timeoutInterval: 5)
        
        var component = URLComponents()
        component.scheme = "https"
        component.host = "www.dhlottery.co.kr"
        component.path = "/common.do"
        component.queryItems = [
            URLQueryItem(name: "method", value: "getLottoNumber"),
            URLQueryItem(name: "drwNo", value: "1100")
        ]
        
        let request = URLRequest(url: component.url!, timeoutInterval: 5)
        
        // 내부적으로 글로벌로 보냄
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Failed Request")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                guard let data else {
                    print("No Data Returned")
                    completionHandler(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("Unable Response")
                    completionHandler(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("Failed Response")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                print("식판ㄱㄱ")
                
                do {
                    // AF...responseDecodable
                    let result = try JSONDecoder().decode(Lotto.self, from: data)
                    completionHandler(result, nil)
                    print("Success")
                } catch {
                    print("Error")
                    completionHandler(nil, .invalidData)
                }
            }
            
        }.resume()
        
    }
    
}

