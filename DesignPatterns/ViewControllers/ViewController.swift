//
//  ViewController.swift
//  DesignPatterns
//
//  Created by ajaybabu singineedi on 28/12/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        testSingleton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func testSingleton(){
        let concurrentQueue = DispatchQueue(label: "Concurrent.Queue", qos: DispatchQoS.userInitiated, attributes: DispatchQueue.Attributes.concurrent)
        for _ in 1...100{
            concurrentQueue.async {
                sharedDataManager.addUserEmail("test@apple.com")
            }
        }
        
        for _ in 1...100{
            concurrentQueue.async {
                sharedDataManager.addUserMobile("+911234567890")
            }
        }
    }
    
}

