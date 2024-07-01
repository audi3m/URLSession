//
//  UI+Ex.swift
//  URLSession
//
//  Created by J Oh on 6/27/24.
//

import UIKit

struct Cast {
    let name: String
    let age: Int
}

struct Movie {
    let name: String
    let runtime: Int
}

struct DummyData<T, U> {
    let main: T
    let sub: U
}

extension UIViewController {
    
    // 공통적인 특성
    func configureBorder<Jack: UIView>(_ view: Jack) {
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.backgroundColor = .brown
    }
    
//    func configureBorder(_ view: UIButton) {
//        view.layer.borderWidth = 1
//        view.layer.borderColor = UIColor.black.cgColor
//        view.layer.cornerRadius = 8
//        view.clipsToBounds = true
//        view.backgroundColor = .clear
//    }
//    
//    func configureBorder(_ view: UITextField) {
//        view.layer.borderWidth = 1
//        view.layer.borderColor = UIColor.black.cgColor
//        view.layer.cornerRadius = 8
//        view.clipsToBounds = true
//        view.backgroundColor = .clear
//    }
    
    // 제네릭 - 범용타입. <>
    // Type parameter - T  
    // >> Placeholder 같은역할
    // >> 같은 타입이 들어감
    // 호출시 타입이 결정 됨
    // Type Constraints - 프로토콜 제약, 클래스 제약
    func plus<T: Numeric>(a: T, b: T) -> T {
        return a + b
    }
    
//    func plus(a: Double, b: Double) -> Double {
//        return a + b
//    }
//    
//    func plus(a: String, b: String) -> String {
//        return a + b
//    }
    
}

