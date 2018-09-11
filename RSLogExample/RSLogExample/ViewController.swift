//
//  ViewController.swift
//  RSLogExample
//
//  Created by Роман Анистратенко on 27/06/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        testLog()
    }
    
    func testLog() {
        log.info("This is an info message")
        log.warning("This is a warning message")
        log.error("This is an error message")
//        log.fatalError("This is a fatal error message")
    }

}

