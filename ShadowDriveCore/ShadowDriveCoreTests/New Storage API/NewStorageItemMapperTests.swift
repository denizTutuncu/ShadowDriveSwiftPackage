//
//  NewStorageItemMapperTests.swift
//  ShadowDriveCoreTests
//
//  Created by Deniz Tutuncu on 12/28/23.
//

import XCTest
import ShadowDriveCore

class NewStorageItemMapperTests: XCTestCase {
    
    func test_map_throwsErrorOnNon200HTTPResponse() throws {
        let validResponse = makeResponseItem(shadowBucket: "Shadow Bucket ID", transactionSignature: "Transaction Signature")
        let json = validResponse.json
        let data = makeItemJSONData(json)
        let samples = [150, 199, 300, 400, 500]
        
        try samples.forEach { code in
            XCTAssertThrowsError(
                try NewStorageItemMapper.map(data, from: HTTPURLResponse(statusCode: code))
            )
        }
    }
    
    func test_map_throwsErrorOn200HTTPResponseWithInvalidJSON() {
        let invalidJSON = Data("invalid json".utf8)
        
        XCTAssertThrowsError(
            try NewStorageItemMapper.map(invalidJSON, from: HTTPURLResponse(statusCode: 200))
        )
    }
    
    func test_map_throwsErrorOn200HTTPResponseWithEmptyJSON() throws {
        let emptyData = makeItemJSONData([:])
        XCTAssertThrowsError(
            try NewStorageItemMapper.map(emptyData, from: HTTPURLResponse(statusCode: 200))
        )
    }
    
    func test_map_deliversResponseOn200HTTPResponseWithJSON() throws {
        let validResponse = makeResponseItem(shadowBucket: "Shadow Bucket ID", transactionSignature: "Transaction Signature")
        let json = validResponse.json
        let data = makeItemJSONData(json)
        
        let result = try NewStorageItemMapper.map(data, from: HTTPURLResponse(statusCode: 200))
        
        XCTAssertEqual(result, validResponse.model)
    }
    
    private func makeResponseItem(shadowBucket: String, transactionSignature: String) -> (model: NewStorage, json: [String:Any]) {
        let model = NewStorage(shadowBucket: shadowBucket, transactionSignature: transactionSignature)
        let json = [
            "shadowBucket": shadowBucket,
            "transactionSignature": transactionSignature
        ].compactMapValues { $0 }
        return (model, json)
    }
    
    private func makeItemJSONData(_ item: [String:Any]) -> Data {
        let json = ["result": item]
        return try! JSONSerialization.data(withJSONObject: json)
    }
    
}
