//
//  SearchView.swift
//  URLSession
//
//  Created by J Oh on 6/25/24.
//

import UIKit
import SnapKit

class SearchView: BaseView {
    
    let searchBar = UISearchBar()
    // VC 인스턴스 생성 전에 클로저가 먼저 실행된다.
    // 프로퍼티가 초기화 되어야 인스턴스가 생성된다. ex) let user = User(name: "Aaa", age: 10)
    let resultLabel = {
        let view = UILabel()
        print("Result Label")
        view.textAlignment = .center
        view.numberOfLines = 0
        view.text = "검색 결과가 없습니다"
        return view
    }()
    
    override func setHierarchy() {
        addSubview(searchBar)
        addSubview(resultLabel)
    }
    
    override func setLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func setView() {
        searchBar.placeholder = "아무거나 검색해보세요"
        searchBar.delegate = self
        
        resultLabel.textAlignment = .center
        resultLabel.numberOfLines = 0
        resultLabel.text = "검색 결과가 없습니다"
    }
    
}

// delegate를 view에서 채택하고 사용해도 되지만,
// 화면 전환, 푸쉬, Alert 등은 VC에서만 가능

extension SearchView: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("검색 버튼 클릭")
        resultLabel.text = "테스트 확인"
    }
    
}
