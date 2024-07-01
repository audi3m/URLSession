//
//  BaseView.swift
//  URLSession
//
//  Created by J Oh on 6/25/24.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
        setView()
         
    }
    
    func setHierarchy() { }
    func setLayout() { }
    func setView() { }
    
    
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
}
