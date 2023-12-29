//
//  NewStorageTransaction.swift
//  ShadowDriveCore
//
//  Created by Deniz Tutuncu on 12/28/23.
//

import Foundation

public struct NewStorageTransaction: Encodable, Equatable {
    public init(instructions: [Data],
                recentBlockhash: Data
    ) {
        self.instructions = instructions
        self.recentBlockhash = recentBlockhash
    }
     public let instructions: [Data]
     public let recentBlockhash: Data
}
