//
//  NewStorageEndpointTests.swift
//  ShadowDriveCoreTests
//
//  Created by Deniz Tutuncu on 12/28/23.
//

import XCTest
import ShadowDriveCore

class NewStorageEndpointTests: XCTestCase {

    func test_newStorageAccount_endpointURLThrowsAfterGivenInvalidTransactionData() {
        let baseURL = URL(string: "http://base-url.com")!
        let invalidTransactionData = unvalidNewStorageTransaction()
                
        XCTAssertThrowsError(
            try NewStorageEndpoint.get(after: invalidTransactionData).url(baseURL: baseURL)
        )
        
    }
    
    func test_newStorageAccount_endpointURLAfterGivenValidTransactionData() {
        let baseURL = URL(string: "https://base-url.com")!
        let validNewStorageTransaction = validTransaction()
        let received = try? NewStorageEndpoint.get(after: validNewStorageTransaction).url(baseURL: baseURL)
                
        XCTAssertEqual(received?.url?.scheme, "https", "scheme")
        XCTAssertEqual(received?.url?.host, "base-url.com", "host")
        XCTAssertEqual(received?.url?.absoluteString, "https://base-url.com/storage-account", "absoluteString")
    }
}
