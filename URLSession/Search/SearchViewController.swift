//
//  SearchViewController.swift
//  URLSession
//
//  Created by J Oh on 6/25/24.
//

import UIKit
import SnapKit

/*
 Meta Type: 타입의 타입
 
 */

struct User {
    let name = "고래밥"
    static let originalName = "Jack"
}

class SearchViewController: BaseViewController {
    
    let mainView = SearchView()
    
    // viewDidLoad보다 먼저 실행됨
    // VC의 루트뷰를 생성해주는 기능
    // super.loadView() 절대 호출 안함
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
        let user = User()
        
        TMDBApi.shared.request(api: .trendingMovie, model: TrendResponse.self) { trend, error in
            trend?.results
        }
        
        
        print(type(of: user.name))
        print(type(of: user)) // User라는 인스턴스의 타입
        print(type(of: User.self))
        print(type(of: User.originalName))
        
//        TMDBManager.shared.callRequest { lotto, error in
//            self.mainView.resultLabel.text = lotto?.drwNoDate
//        }
    }
    
    override func setHierarchy() {
        
    }
    
    override func setLayout() {
        
    }
    
    override func setView() {
        
    }
    
}
