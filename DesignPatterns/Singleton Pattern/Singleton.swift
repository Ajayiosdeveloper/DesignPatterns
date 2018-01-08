//
//  DataManager.swift
//  DesignPatterns
//
//  Created by ajaybabu singineedi on 03/01/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import Foundation

//Global Constant Method
//Global Constants and Variables are lazily initialised and thread safe that is garenteed by Swift Language.

let sharedDataManager: DataManager = DataManager()

final class DataManager {
    var userName: String = String()

    //Manipulating Swift arrays are not thread Safe.When two or more Threads try to add contents in an array at same time then it will crash with giving errors: either "UnsafeMutablePointer.deinitialize with negative count" or "error for object 0x111133c88: pointer being freed was not allocated"
    var emails: [String] = [String]()
    var mobileNumbers: [String] = [String]()
    
    //For Serializing the array access.So only one thread will manipulate array at any one time.(Which avoids multple threads conflicting and corrupting the data.)
    private let serialQueue = DispatchQueue(label: "Serail.Queue")
    
    fileprivate init(){
    
    }
    
    func addUserEmail(_ email: String){
        //When multiple therads come asynchronously, then this serail queue will enfore them to be executed one after one serially at any one time.
        serialQueue.sync {
             print(email)
             emails.append(email)
        }
    }
    
    func addUserMobile(_ mobile: String){
        //When multiple therads come asynchronously, then this serail queue will enfore them to be executed one after one serially at any one time.
        serialQueue.sync {
            print(mobile)
            mobileNumbers.append(mobile)
        }
    }
}


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

//Conventional way using Nested Structure before Swift 1.2

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


//Readers-Writers Problems and Avoid using barriers queue.
//Problem: As multiple threads reading data at sametime from array/dictionary will not create any problem as long as there is no writing operation happes when reading.If we are reading from one therad and another therad is writing into the arry/dictionary at same time then will craete readers-writers problem.So we have to choose a way so that writing operations will be happen serially and reading operations will happen concurrently and no writing operations happen when reading and no reading oeprations will happen when writing.This will speed up the tasks and also provide more consistency across concurrent operations.

/*Solution: When a barrier block
 reaches the head of the queue, GCD waits until all of the read operations that
 are still in process have completed. Once they are all done, GCD executes the
 barrier block-which modifies the array—and does not process any subsequent
 blocks until the barrier block has completed. Once the barrier block is
 complete, the following items in the queue are processed as normal and in
 parallel until the next barrier block comes along
 Put another way, using a barrier changes a concurrent queue into a serial
 queue for as long as it takes to process the barrier block, after which it returns
 to being a concurrent queue again. Whichever way you prefer to think
 of it, using a GCD barrier makes it easy to create a reader/writer lock.*/

class Logger<T: NSObject & NSCopying> {
    var dataItems: [T] = [T]()
    var callback: (T)-> Void
    private let concurrentQueue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)
    
    init(callback: @escaping (T)->Void){
        self.callback = callback
    }
    
    func logItem(item: T){
        concurrentQueue.async(flags: .barrier) {
            self.dataItems.append(item.copy() as! T)
            self.callback(item)
        }
    }
    
    func processItems(callback: (T)->Void){
        concurrentQueue.sync {
            for item in dataItems {
                callback(item)
            }
        }
    }
}
