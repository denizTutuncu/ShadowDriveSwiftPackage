//
//  XCTestCase+MemoryLeakTracking.swift
//  ShadowDriveCoreTests
//
//  Created by Deniz Tutuncu on 12/28/23.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should be deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
