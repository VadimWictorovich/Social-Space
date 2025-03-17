//
//  Networkservice.swift
//  SocialSpace
//
//  Created by Вадим Игнатенко on 17.03.25.
//

import Foundation
import Alamofire


final class Networkservice {
    
    static let shared = Networkservice()
    private init() {}
        
    func getPosts(callback: @escaping (_ result: [Post]?, _ error: Error?) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { print (" * \(#function) URL error"); return }
            requestData(url: url, callback: callback)
    }
    
    func getUser(id: Int, callback: @escaping (_ result: User?, _ error: Error?) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users/\(id)") else { print (" * \(#function) URL error"); return }
            requestData(url: url, callback: callback)
    }
    
    private func requestData<T: Codable>(url: URL, callback: @escaping (T?, Error?) -> ()) {
        AF.request(url, method: .get, encoding: JSONEncoding.default)
            .response {  [self] response in
                var value: T?, err: Error?
                switch response.result {
                case .success(let data): guard let data else { callback(nil, nil); return }
                    value = parseJSON(data: data)
                case .failure(let error): err = error
                }
                callback(value, err)
            }
    }
    
    private func parseJSON<T: Codable>( data: Data) -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print(" * \(#function) - \(error)")
            return nil
            }
        }
}
