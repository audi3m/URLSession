//
//  BaseViewController.swift
//  URLSession
//
//  Created by J Oh on 6/25/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setHierarchy()
        setLayout()
        setView()
    }
    
    func setHierarchy() { }
    func setLayout() { }
    func setView() { }
    
}
