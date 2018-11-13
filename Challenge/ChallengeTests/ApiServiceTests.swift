//
//  ChallengeTests.swift
//  ChallengeTests
//
//  Created by Felix Changoo on 11/12/18.
//  Copyright © 2018 Felix Changoo. All rights reserved.
//

import XCTest
@testable import Challenge

class ApiServiceTests: XCTestCase {
    var apiService: ApiService!
    let session = MockURLSession()
    
    override func setUp() {
        apiService = ApiService(session: session)
    }
    
    func testGetWithURL() {
        let url = URL(string: "http://fakesite.com")!
        apiService.get(from: url) { data, error in }
        
        XCTAssert(session.url == url)
    }
    
    func testGetResumeCalled() {
        let dataTask = MockURLSessionDataTask()
        session.task = dataTask
        
        let url = URL(string: "http://fakesite.com")!
        apiService.get(from: url) { data, error in }
        
        XCTAssertTrue(dataTask.resumeCalled)
    }
    
    func testGetShouldReturnData() {
        let fakeData = "{}".data(using: .utf8)
        session.data = fakeData
        
        var actualData: Data?
        apiService.get(from: URL(string: "http://fakesite.com")!) { (data, error) in
            actualData = data
        }
        
        XCTAssertNotNil(actualData)
    }

    override func tearDown() {
        
    }
}

//Mock classes
class MockURLSession: URLSessionProtocol {
    
    var task = MockURLSessionDataTask()
    var data: Data?
    var error: Error?
    
    private (set) var url: URL?
    
    func successHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        url = request.url
        
        completionHandler(data, successHttpURLResponse(request: request), error)
        return task
    }
    
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeCalled = false
    
    func resume() {
        resumeCalled = true
    }
}
