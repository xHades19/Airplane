//
//  ViewController.swift
//  Airplane
//
//  Created by xHadesvn
//  Copyright © 2016 xHadesvn. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let airPlaneView = AirPlaneView(frame: view.bounds)
        view.addSubview(airPlaneView)
    }
}

