//
//  Alert+Ex.swift
//  URLSession
//
//  Created by J Oh on 6/24/24.
//

import UIKit

extension UIViewController {
    
    // showAlert는 present로 얼럿이 뜨는 순간 생명주기가 끝남. 더 이상 실행할 코드 없음.
    // 끝나도 실행 시켜야 하기 때문에 @escaping
    func showAlert(title: String, message: String, ok: String, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: ok, style: .default) { _ in
            completionHandler()
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    func showAlert2(title: String, message: String, ok: String, completionHandler: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: ok, style: .default, handler: completionHandler)
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
}
