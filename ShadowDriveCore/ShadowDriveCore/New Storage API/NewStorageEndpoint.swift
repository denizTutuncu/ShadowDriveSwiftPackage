//
//  NewStorageEndpoint.swift
//  ShadowDriveCore
//
//  Created by Deniz Tutuncu on 12/28/23.
//

import Foundation

public enum NewStorageEndpoint {
    case get(after: NewStorageTransaction)
    
    public func url(baseURL: URL) throws -> URLRequest {
        switch self {
        case let .get(newStroageTransaction):
            var components = URLComponents()
            components.scheme = baseURL.scheme
            components.host = baseURL.host
            components.path = baseURL.path + "/storage-account"
            
            var request = URLRequest(url: components.url!)
            request.httpMethod = "POST"
            
            
            let newStorageTransactionData = try NewStorageTransactionItemMapper.map(newStroageTransaction)
            request.httpBody = newStorageTransactionData
            
            let headers = ["Content-Type":"application/json"]
            for header in headers {
                request.setValue(header.value, forHTTPHeaderField: header.key)
            }
            
            return request
        }
    }
}

