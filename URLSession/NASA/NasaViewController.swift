//
//  NasaViewController.swift
//  URLSession
//
//  Created by J Oh on 7/1/24.
//

import UIKit
import SnapKit

class NasaViewController: BaseViewController {
    
    let nasaImageView = UIImageView()
    let progressLabel = UILabel()
    let requestButton = UIButton()
    
    var total: Double = 0
    var buffer: Data? {
        didSet {
            let result = Double(buffer?.count ?? 0) / total
            progressLabel.text = String(format: "%.0f", result * 100) + "%"
        }
    }
    
    // 다운로드 중 화면 전환하면 네트워크와 관련된 리소스 정리 필요
    var session: URLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 앱을 날리면 호출되지 않음
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 화면 사라지면 통신도 중단
        // 다운로드 중인 리소스도 무시
        session.invalidateAndCancel()
        
        // 다운로드 완료 후 리소스 정리
        session.finishTasksAndInvalidate()
        
    }
    
    
    func nasaRequest() {
        let url = Nasa.photo
        let request = URLRequest(url: url)
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        // URLSession.shared.... 에서는 한 번에 표시
        
        // .default는
        session.dataTask(with: request).resume()
        
    }
    
    
    @objc func requestButtonClicked() {
        buffer = Data()
        nasaImageView.image = UIImage()
        requestButton.isEnabled = false
        requestButton.backgroundColor = .lightGray
        nasaRequest()
    }
    
    override func setHierarchy() {
        view.addSubview(nasaImageView)
        view.addSubview(progressLabel)
        view.addSubview(requestButton)
    }
    
    override func setLayout() {
        nasaImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(400)
        }
        
        progressLabel.snp.makeConstraints { make in
            make.top.equalTo(nasaImageView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(50)
        }
        
        requestButton.snp.makeConstraints { make in
            make.top.equalTo(progressLabel.snp.bottom).offset(50)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(50)
        }
    }
    
    override func setView() {
        nasaImageView.backgroundColor = .lightGray
        nasaImageView.contentMode = .scaleAspectFit
        
        progressLabel.backgroundColor = .lightGray
        progressLabel.textAlignment = .center
        
        requestButton.backgroundColor = .gray
        requestButton.addTarget(self, action: #selector(requestButtonClicked), for: .touchUpInside)
    }
    
    enum Nasa: String, CaseIterable {
        
        static let baseURL = "https://apod.nasa.gov/apod/image/"
        
        case one = "2308/sombrero_spitzer_3000.jpg"
        case two = "2212/NGC1365-CDK24-CDK17.jpg"
        case three = "2307/M64Hubble.jpg"
        case four = "2306/BeyondEarth_Unknown_3000.jpg"
        case five = "2307/NGC6559_Block_1311.jpg"
        case six = "2304/OlympusMons_MarsExpress_6000.jpg"
        case seven = "2305/pia23122c-16.jpg"
        case eight = "2308/SunMonster_Wenz_960.jpg"
        case nine = "2307/AldrinVisor_Apollo11_4096.jpg"
        
        static var photo: URL {
            return URL(string: Nasa.baseURL + Nasa.allCases.randomElement()!.rawValue)!
        }
    }
    
}

// vs URLSessionDelegate
// 쪼개져서 조금씩 받아옴
extension NasaViewController: URLSessionDataDelegate {
    
    // response
    // 최초 응답
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        print(#function, response)
        
        if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
            let contentLength = response.value(forHTTPHeaderField: "Content-Length")!
            total = Double(contentLength)!
            progressLabel.text = "\(total)"
            return .allow
        } else {
            return .cancel
        }
        
    }
    
    // data
    // 데이터 받아올 때마다 호출됨
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print(#function, data)
        buffer?.append(data)
    }
    
    // error
    // 응답이 완료될 떄 호출됨
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
        print(#function, error)
        
        if let _ = error {
            progressLabel.text = "Error"
        } else {
            // completion 시점과 동일
            guard let buffer else { return }
            nasaImageView.image = UIImage(data: buffer)
            requestButton.isEnabled = true
            requestButton.backgroundColor = .gray
            
        }
    }
    
}



