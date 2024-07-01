//
//  PosterTableViewCell.swift
//  URLSession
//
//  Created by J Oh on 6/25/24.
//

import UIKit
import SnapKit

class PosterTableViewCell: BaseTableViewCell {
    static let id = "PosterTableViewCell"
    
    private let titleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 17)
        view.text = "비슷한 영화"
        view.textColor = .black
        return view
    }()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    static private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 160)
        return layout
    }
    
    override func setHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(15)
            make.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.horizontalEdges.bottom.equalTo(contentView)
        }
        
    }
    
    override func setView() {
        
        
    }
    
}
