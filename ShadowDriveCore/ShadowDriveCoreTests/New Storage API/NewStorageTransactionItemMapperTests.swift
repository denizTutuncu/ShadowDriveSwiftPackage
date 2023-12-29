//
//  NewStorageTransactionItemMapperTests.swift
//  ShadowDriveCoreTests
//
//  Created by Deniz Tutuncu on 12/28/23.
//

import XCTest
import ShadowDriveCore

class NewStorageTransactionItemMapperTests: XCTestCase {
    
    func test_map_throwsErrorOnNewStorageTransactionWithEmptyInstructions() throws {
        let emptyNewStorageTransaction = makeNewStorageTransaction(instructions: [], recentBlockhash: Data())
        XCTAssertThrowsError(
            try NewStorageTransactionItemMapper.map(emptyNewStorageTransaction.model)
        )
    }
    
    func test_map_deliversNewStorageTransactionWithInstructions() throws {
        let validNewStorageTransaction = makeNewStorageTransaction(instructions: [Data(), Data()], recentBlockhash: Data())
        let model = validNewStorageTransaction.model
        let data = validNewStorageTransaction.data
        
        let result = try NewStorageTransactionItemMapper.map(model)
        
        XCTAssertEqual(result, data)
    }
    
    private func makeNewStorageTransaction(instructions: [Data], recentBlockhash: Data)  -> (model: NewStorageTransaction, data: Data) {
        let model = NewStorageTransaction(instructions: instructions, recentBlockhash: recentBlockhash)
        
        let data = makeData(model)
        
        return (model, data)
    }
    
    private func makeData(_ item: NewStorageTransaction) -> Data {
        return try! JSONEncoder().encode(item)
    }
    
}
