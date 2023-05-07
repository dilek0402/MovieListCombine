//
//  URLSession+Extension.swift
//  MovieList
//
//  Created by Dilek Eminoğlu on 03.03.2023.
//

import Foundation

extension URLSession {
    
    // MARK: - Public MEthods
    
    func sendRequest<T: Decodable>(url: URL,
                                   completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask  {
        return self.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completionHandler(nil, response, error)
                return
            }
            if let response = response as? HTTPURLResponse,
               (200..<300).contains(response.statusCode) == false {
                completionHandler(nil, response, nil)
            }
            guard let data = data else {
                completionHandler(nil, response, nil)
                return
            }
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                completionHandler(model, response, nil)
            } catch(let error) {
                completionHandler(nil, response, error)
            }
        }
    }
}
