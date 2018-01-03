//
//  DataManager.swift
//  DesignPatterns
//
//  Created by ajaybabu singineedi on 03/01/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import Foundation

//Global Constant Method
//Global Constants and Variables are lazily initialised and thread safe

final class DataManager {
    var userName: String = String()
    var emails: [String] = [String]()
    
    fileprivate init(){
    
    }
}

let sharedDataManager = DataManager()

//Class Constant Method
//type stored properties are supported from Swift 1.2

final class SessionManager {
    
    var name: String?
    var userId: Int?
    
    private init(){
        
    }
    static let shared = SessionManager()
}

let manager = SessionManager.shared

//Conventional way using Nested Structure

final class ConnectionManager {
    var url: URL?
    
    class var sharedInstance: ConnectionManager {
        
        struct SingletonWrapper {
            static let instance = ConnectionManager()
        }
        return SingletonWrapper.instance
    }
    
    private init(){
        
    }
}

let connectionManager = ConnectionManager.sharedInstance
