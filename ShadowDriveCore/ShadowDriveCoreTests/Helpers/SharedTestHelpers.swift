//
//  SharedTestHelpers.swift
//  ShadowDriveCoreTests
//
//  Created by Deniz Tutuncu on 12/28/23.
//

import Foundation
import ShadowDriveCore

extension HTTPURLResponse {
    convenience init(statusCode: Int) {
        self.init(url: anyURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}

func unvalidNewStorageTransaction() -> NewStorageTransaction {
    return NewStorageTransaction(instructions: [])
}

func validTransaction() -> NewStorageTransaction {
    return NewStorageTransaction(instructions: validInstructions())
}

private func validInstructions() -> [Data] {
    let temporarayNewTransactionData = [Data(), Data()]
    return temporarayNewTransactionData
}

func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}

func anyData() -> Data {
    return Data("Any data".utf8)
}

func testURLRequest() -> URLRequest {
    var urlRequest = URLRequest(url: anyURL())
    urlRequest.httpMethod = "POST"
    urlRequest.httpBody = anyData()
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    return urlRequest
}
