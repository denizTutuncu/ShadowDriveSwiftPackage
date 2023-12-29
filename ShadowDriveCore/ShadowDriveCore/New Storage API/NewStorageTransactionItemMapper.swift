//
//  NewStorageTransactionItemMapper.swift
//  ShadowDriveCore
//
//  Created by Deniz Tutuncu on 12/28/23.
//

import Foundation

public final class NewStorageTransactionItemMapper {
    
    public enum Error: Swift.Error {
        case encoder
        case invalidInstructions
    }
    
    public static func map(_ data: NewStorageTransaction) throws -> Data {
        guard !data.instructions.isEmpty else { throw Error.invalidInstructions }
        do {
            let jsonData = try JSONEncoder().encode(data)
            return jsonData
        } catch {
            throw Error.encoder
        }
    }
}
