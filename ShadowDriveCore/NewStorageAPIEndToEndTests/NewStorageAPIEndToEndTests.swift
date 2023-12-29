//
//  NewStorageAPIEndToEndTests.swift
//  NewStorageAPIEndToEndTests
//
//  Created by Deniz Tutuncu on 12/28/23.
//

import XCTest
import ShadowDriveCore

class NewStorageAPIEndToEndTests: XCTestCase {
    
    func test_endToEndTestServerGETFeedResult_matchesFixedTestAccountData() {
        switch getNewStorageResult() {
        case let .success(newStorage)?:
            XCTAssertEqual(newStorage.shadowBucket, createBucket(), "Expected new storage bucket in test create new storage.")
            XCTAssertEqual(newStorage.transactionSignature, createTransactionSignature(), "Expected new storage transaction signature in test create new storage.")
            
        case let .failure(error)?:
            XCTFail("Expected successful balance result, got \(error) instead")
            
        default:
            XCTFail("Expected successful balance result, got no result instead")
        }
    }
    
    // MARK: - Helpers
    private func getNewStorageResult(file: StaticString = #filePath, line: UInt = #line) -> Swift.Result<NewStorage, Error>? {
        let client = ephemeralClient()
        let exp = expectation(description: "Wait for load completion")
        
        var receivedResult: Swift.Result<NewStorage, Error>?
        client.get(from: newStorageTestServerURL) { result in
            receivedResult = result.flatMap { (data, response) in
                do {
                    return .success(try NewStorageItemMapper.map(data, from: response))
                } catch {
                    return .failure(error)
                }
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5.0)
        
        return receivedResult
    }
        
    private var newStorageTestServerURL: URLRequest {
        return try! NewStorageEndpoint.get(after: newStorageTransaction()).url(baseURL: baseURL())
    }
    
    private func ephemeralClient(file: StaticString = #filePath, line: UInt = #line) -> HTTPClient {
        let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
        trackForMemoryLeaks(client, file: file, line: line)
        return client
    }
    
    private func expectedNewStorage(at index: Int) -> NewStorage {
        return NewStorage(shadowBucket: createBucket(), transactionSignature: createTransactionSignature())
    }
    
    private func createBucket() -> String {
        return "CreateBucket"
    }
    
    private func createTransactionSignature() -> String {
        return "CreateTransactionSignature"
    }
    
        //MARK: - Need a real test net url
    private func baseURL() -> URL {
        return URL(string: "https://shadow-storage.genesysgo.net")!
    }
    private func newStorageTransaction() -> NewStorageTransaction {
        return NewStorageTransaction(instructions: [Data(), Data()], recentBlockhash: Data())
    }
    
}
