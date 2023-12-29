//
//  NewStorageItemMapper.swift
//  ShadowDriveCore
//
//  Created by Deniz Tutuncu on 12/28/23.
//

import Foundation

public final class NewStorageItemMapper {
    
    private struct Root: Decodable {
        private let result: RemoteNewStorage
        
        private struct RemoteNewStorage: Decodable {
            let shadowBucket: String
            let transactionSignature: String
        }
        
        var response: NewStorage {
            NewStorage(shadowBucket: result.shadowBucket, transactionSignature: result.transactionSignature)
        }
    }
    
    public enum Error: Swift.Error {
        case invalidData
    }
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> NewStorage {
        guard isOK(response),
              let root = try? JSONDecoder().decode(Root.self, from: data) else {
            throw Error.invalidData
        }
        return root.response
    }
    
    private static func isOK(_ response: HTTPURLResponse) -> Bool {
        (200...299).contains(response.statusCode)
    }
    
}
