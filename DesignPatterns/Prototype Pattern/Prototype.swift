//
//  Prototype.swift
//  DesignPatterns
//
//  Created by ajaybabu singineedi on 08/01/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import Foundation

//Prototype Pattern
//--What is it?
//**The prototype pattern creates new objects by copying an existing object, known as the prototype.

//--What are the benefits?
//**The main benefit is to hide the code that creates objects from the components that use them; this means that components don’t need to know which class or struct is required to create a new object, don’t need to know the details of initializers, and don’t need to change when subclasses are created and instantiated. This pattern can also be used to avoid repeating expensive initialization each time a new object of a specific type is created.

//--When should you use this pattern?
//**This pattern is useful when you are writing a component that needs to create new instances of objects without creating a dependency on the class initializer.

//--When should you avoid this pattern?
//**There are no drawbacks to using this pattern, but you should understand the other patterns in this part of the book to ensure that you pick the most suitable for your application.

//--How do you know when you have implemented the pattern correctly?
//**To test for an effective implementation of this pattern, change the initializer for the class or struct used for the prototype object and check to see whether a corresponding change is required in the component that creates clones. As a second test, create a subclass of the prototype’s class and ensure that the component can clone it without requiring any changes.

//--Are there any common pitfalls?
//**The main pitfall is selecting the wrong style of copying when cloning the prototype object. There are two kinds of copying available—shallow and deep—and it is important to select the correct kind for your application. See the “Understanding Shallow and Deep Copying” section for details.

//--Are there any related patterns?
//**The most closely related pattern is the object template pattern.

//Understanding the Prototype Pattern

/*The prototype pattern uses an existing object—rather than a class or struct—
 to create new objects. This is often referred to as cloning, since the new object
 is an identical copy of the existing one, including any changes made to
 the object’s stored properties that have been made since it was created.There are three operations in the      prototype pattern. First, the component that needs an object calls on the original object (known as the prototype) to copy itself. The second operation is the copying process in which a new object
 (known as the clone) is created. In the final operation, the prototype gives the calling component the clone, completing the copying process.*/

//Implementing the Prototype Pattern
/*Swift automatically applies the prototype pattern when you assign a value
type to a new variable. Values types are defined using structs, and all of the
built-in Swift types are implemented as structs behind the scenes, meaning
that you can clone strings, Booleans, collections, enumerations, tuples, and
numeric types just by assigning them to a new variable. Swift will copy the
value of the prototype and use it to create a clone.*/

//Value types: Objects created uisng Struct, Enum, Tuple are value types. Objects created uisng Classes are reference types. Swift Closures are also reference types.

class NoteBook : NSObject, NSCopying {
    var title: String
    var price: Double
    var pages: Int
    
    init(_ title: String, price: Double, pages: Int) {
        self.title = title
        self.pages = pages
        self.price = price
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return NoteBook(self.title, price: self.price, pages: self.pages)
    }
}

//Shallow Copy
class TextBook : NSObject, NSCopying {
    var title: String
    var price: Double
    var pages: Int
    var author: Author
    
    init(_ title: String, price: Double, pages: Int, author: Author) {
        self.title = title
        self.pages = pages
        self.price = price
        self.author = author
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return TextBook(self.title, price: self.price, pages: self.pages, author: self.author)
    }
}

class Author {
    var name: String
    var email: String
    
    init(_ name: String, _ email: String) {
        self.name = name
        self.email = email
    }
}

// Deep Copy

/*class TextBook : NSObject, NSCopying {
    var title: String
    var price: Double
    var pages: Int
    var author: Author
    
    init(_ title: String, price: Double, pages: Int, author: Author) {
        self.title = title
        self.pages = pages
        self.price = price
        self.author = author
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return TextBook(self.title, price: self.price, pages: self.pages, author: self.author.copy() as! Author)
    }
}

class Author : NSObject, NSCopying {
    var name: String
    var email: String
    
    init(_ name: String, _ email: String) {
        self.name = name
        self.email = email
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Author(self.name, self.email)
    }
}*/

//@NSCopying Attribute: Will generate setter which will call the copying method when you asing to another variables. variables that are marked with @NSCopying should conform and impament NSCOpying protocol.
//Limitations: The first is that values set during initialization are not cloned, which is why I defined the  property of the  class as optional so that I don’t have to set values for them in an initializer.


class Mobile {
    var name: String
    @NSCopying var processor: Processor?
    
    init(_ name: String) {
        self.name = name
    }
}

class Processor : NSObject, NSCopying {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Processor(name: self.name)
    }
}
