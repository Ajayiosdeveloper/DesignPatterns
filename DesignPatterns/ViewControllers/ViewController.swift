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
        //testSingleton()
        //testPrototype()
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
    
    func testPrototype() {
        let noteBook = NoteBook("Single Rule", price: 20, pages: 100)
        let anotherNoteBook = noteBook.copy() as! NoteBook
        noteBook.price = 15
        print(noteBook.price)
        print(anotherNoteBook.price)
        
        // Shallow Copy & Deep Copy
        let swiftBook = TextBook("Swift Programming Guide", price: 3000, pages: 400, author: Author("Apple", "www.swift.org"))
        let swiftBookCopy = swiftBook.copy() as! TextBook
        
        swiftBook.price = 9000
        print(swiftBook.price)
        print(swiftBookCopy.price)
        
        swiftBook.author.name = "Apple Inc"
        print(swiftBook.author.name)
        print(swiftBookCopy.author.name)
        
        // Deep Copying Swift Array of Value Types. Swift Structs are subject to Shallow Copy.
        
        let bookArray: [NoteBook] = [NoteBook("Single Rule", price: 20, pages: 100),NoteBook("Double Rule", price: 20, pages: 100)]
        /*let bookArrayCopy = bookArray
        if we do this, Swift array will copy the references to the newly copied array.So when we do changes in one array then it will affect the other array*/
        
        //Deep Copying Swift Array of Value Types
        func deepCopying(array: [AnyObject]) -> [AnyObject] {
            return array.map{ (item) -> AnyObject in
                if item is NSObject && item is NSCopying {
                  return (item as! NSObject).copy() as AnyObject
                }
                return item
            }
        }
        
        let bookArrayCopy = deepCopying(array: bookArray) as! [NoteBook]
        bookArray[0].title = "White Pages"
        print(bookArray[0].title)
        print(bookArrayCopy[0].title)
        
        
        //@NSCopying Attribute
        let mobile = Mobile("iPhone 7")
        let processor = Processor(name: "ARMv")
        mobile.processor = processor // will call the copyWithZone method in Processor and gives a copy.
        processor.name = "ARMv7"
        print(mobile.processor!.name)
        print(processor.name)
    }
    
}

