//
//  UrlProtocols.swift
//  Challenge
//
//  Created by Felix Changoo on 11/13/18.
//  Copyright © 2018 Felix Changoo. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
}
