//
//  NetworkHelper.swift
//  MatrixColorDemo
//
//  Created by Connor on 2023/8/21.
//

import Foundation

protocol MockNetworkProtocol {
    func fetchData(from url: URL, completion: @escaping(_ data: ColorModel?, Error?) -> Void)
}

class NetworkHelper: MockNetworkProtocol {
    static let shared = NetworkHelper()
    
    private init() {}
    func fetchData(from url: URL, completion: @escaping (ColorModel?, Error?) -> Void) {
        
        guard let jsonFileUrl = Bundle(for: type(of: self)).url(forResource: "Color", withExtension: "json")
        else {
            let error = NSError(domain: "NetworkHelper wrong json file", code: 404, userInfo: nil)
            completion(nil, error)
            return
        }
        
        do {
            let data = try Data(contentsOf: jsonFileUrl)
            let decoder = JSONDecoder()
            let colorData = try decoder.decode(ColorModel.self, from: data)
            completion(colorData, nil)
        } catch {
            completion(nil, NSError(domain: "Color Decode Fail", code: 5566))
        }
    }
}
