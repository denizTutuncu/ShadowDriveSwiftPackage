//
//  NewStorage.swift
//  ShadowDriveCore
//
//  Created by Deniz Tutuncu on 12/28/23.
//

import Foundation

public struct NewStorage: Equatable  {
    public init(shadowBucket: String,
                transactionSignature: String)
    {
        self.shadowBucket = shadowBucket
        self.transactionSignature = transactionSignature
    }
    
    public let shadowBucket: String
    public let transactionSignature: String
}
