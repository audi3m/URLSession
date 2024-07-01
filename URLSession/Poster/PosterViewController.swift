//
//  PosterViewController.swift
//  URLSession
//
//  Created by J Oh on 6/25/24.
//

import UIKit
import Kingfisher
import SnapKit

/*
 컴파일 최적화: 파일/코드기 서로 영향 없도록. 필요한 것들만 연결고리가 만들어지게
 - final: 클래스 상속 x
 - 접근제어: private
 => Method Dispatch (Static Dispatch / Dynamic Dispatch)
 
 */

final class PosterViewController: BaseViewController {
    
    // self는 PosterViewController()이기 때문에
    lazy var tableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(PosterTableViewCell.self, forCellReuseIdentifier: PosterTableViewCell.id)
        view.rowHeight = 200
        return view
    }()
    
    var list: [[String]] = [[], []]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // notify (일반적)
        // enter - leave (함수 안에 비동기 함수가 있을 때)
//        let group = DispatchGroup()
        
//        TMDBManager.shared.callRequest { lotto, error in
//            
//        }
        
        aboutGCD()
        
    }
    
    func aboutGCD() {
        let group = DispatchGroup()
        // 일 보내기 직전 요청
        group.enter() // +1
        DispatchQueue.global().async(group: group) {
            TMDBApi.shared.trending(api: .trendingMovie) { (data, error) in
                if let error {
                    print(error)
                } else {
                    guard let data else { return }
                    self.list[0] = data.map { TrendAPI.posterUrl + $0.poster_path }
                    print("======2222222======")
                }
                group.leave() // -1
            }
        }
        
        group.enter() // +1
        DispatchQueue.global().async(group: group) {
            TMDBApi.shared.trending(api: .trendingTV) { (data, error) in
                if let error {
                    print(error)
                } else {
                    guard let data else { return }
                    self.list[1] = data.map { TrendAPI.posterUrl + $0.poster_path }
                    print("======2222222======")
                }
                group.leave() // -1
            }
        }
        
        // 0이 되면 실행됨. 성공한 경우만 고려
        group.notify(queue: .main) {
            self.tableView.reloadData()
            print("======== 끝 ========")
        }
    }
    
    override func setHierarchy() {
        view.addSubview(tableView)
    }
    
    override func setLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension PosterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.id, for: indexPath) as! PosterTableViewCell
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        cell.collectionView.tag = indexPath.row
        cell.collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.id)
        cell.collectionView.reloadData()
        return cell
    }
    
}

extension PosterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let tag = collectionView.tag
        return list[tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.id, for: indexPath) as! PosterCollectionViewCell
        let data = list[collectionView.tag][indexPath.item]
        cell.posterImageView.kf.setImage(with: URL(string: data)!)
        return cell
    }
    
}
