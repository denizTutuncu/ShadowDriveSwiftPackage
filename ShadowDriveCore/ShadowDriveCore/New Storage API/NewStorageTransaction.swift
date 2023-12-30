//
//  NewStorageTransaction.swift
//  ShadowDriveCore
//
//  Created by Deniz Tutuncu on 12/28/23.
//

import Foundation

public struct NewStorageTransaction: Encodable, Equatable {
    public init(instructions: [Data]) {
        self.instructions = instructions
    }
     public let instructions: [Data]
}
