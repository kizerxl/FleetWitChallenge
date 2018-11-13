//
//  ApiService.swift
//  Challenge
//
//  Created by Felix Changoo on 11/12/18.
//  Copyright © 2018 Felix Changoo. All rights reserved.
//

import Foundation

enum APIError: String, Error {
    case noNetwork = "No Network Connection"
    case noPermission = "You don't have permission"
}

protocol APIServiceProtocol {
    typealias completion = (_ data: Data?, _ error: Error?) -> Void
    func get(from url: URL, completionHandler: @escaping completion)
}

class ApiService: APIServiceProtocol {
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func get(from url: URL, completionHandler: @escaping completion) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { (data, response, error) in
            completionHandler(data, error)
        }
        task.resume()
    }
}

extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping URLSessionProtocol.DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
