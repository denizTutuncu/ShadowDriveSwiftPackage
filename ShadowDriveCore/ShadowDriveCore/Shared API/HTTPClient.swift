//
//  HTTPClient.swift
//  ShadowDriveCore
//
//  Created by Deniz Tutuncu on 12/28/23.
//

import Foundation

public protocol HTTPClientTask {
    func cancel()
}

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    /// The completion handler can be invoked in any tread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    @discardableResult
    func get(from urlRequest: URLRequest, completion: @escaping (Result) -> Void) -> HTTPClientTask
}
