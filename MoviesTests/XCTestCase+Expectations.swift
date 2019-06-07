//
//  XCTestCase+Expectations.swift
//  Movies
//
//  Created by Parul Vats on 03/05/2018.
//  Copyright © 2018 Parul Vats. All rights reserved.
//

import XCTest

extension XCTestCase {
    func waitForExpectations() {
        waitForExpectations(timeout: 0.5) { error in
            guard let error = error else {
                return
            }
            XCTFail(error.localizedDescription)
        }
    }
    
    func loadView(_ view: UIView, in window: UIWindow = UIWindow()) {
        window.addSubview(view)
        RunLoop.current.run(until: Date())
    }
}
