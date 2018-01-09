//
//  FactoryMethod.swift
//  DesignPatterns
//
//  Created by ajaybabu singineedi on 09/01/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import Foundation

//Factory Pattern
//--What is it?
//**The factory method pattern selects an implementation class to satisfy a calling component’s request without requiring the component to know anything about the implementation classes or the way they relate to one another.

//--What are the benefits?
//**This pattern consolidates the logic that decides which implementation class is selected and prevents it from being diffused throughout the application. This also means that calling components rely only on the top-level protocol or base class and do not need any knowledge about the implementation classes or the process by which they are selected.

//--When should you use this pattern?
//**Use this pattern when you have several classes that implement a common protocol or that are derived from the same base class.

//--When should you avoid this pattern?
//**Do not use this pattern when there is no common protocol or shared base class because this pattern works by having the calling component rely on only a single type.

//--How do you know when you have implemented the pattern correctly?
//**This pattern is implemented correctly when the  appropriate class is instantiated without the calling component knowing which class was used or how it was selected.

//--Are there any common pitfalls?
//**No. The factory method pattern is simple to implement.

//--Are there any related patterns?
//**The factory method pattern is often combined with the singleton and object pool patterns.

protocol Phone {
    var ram: Int {get}
    var cammera: Int {get}
    var os: String {get}
}

class iPhone : Phone {
    var ram: Int = 8
    var cammera: Int = 15
    var os: String = "iOS"
}

class Samsung : Phone {
    var ram: Int = 2
    var cammera: Int = 10
    var os: String = "Android"
}

class HTC : Phone {
    var ram: Int = 5
    var cammera: Int = 12
    var os: String = "Windows"
}

class PhoneFactory {
     class func makePhone(with os: String)-> Phone? {
        var phone: Phone?
        switch os {
        case "iOS":
            phone = iPhone()
        case "Android":
            phone = Samsung()
        case "Windows":
            phone = HTC()
        default:
            phone = nil
        }
        return phone
    }
}

class Car {
    var name: String
    var seats: Int
    var price: Int
    
    init(_ name: String, seats: Int, price: Int) {
        self.name = name
        self.seats = seats
        self.price = price
    }
    
    class func createCar(with seats: Int)-> Car? {
        var car: Car.Type?
        switch seats {
        case 5:
            car = Fortuner.self
        case 6:
            car = BMW.self
        case 7:
            car = Skoda.self
        case 8:
            car = Verna.self
        default:
            car = nil
        }
        return car?.createCar(with: seats)
    }
}

class Fortuner : Car {
    init() {
        super.init("Fortuner", seats: 5, price: 10)
    }
    
   override class func createCar(with seats: Int)-> Car? {
        return Fortuner()
    }

}

class BMW : Car {
    init() {
        super.init("BMW", seats: 6, price: 17)
    }
    
    override class func createCar(with seats: Int)-> Car? {
        return BMW()
    }
}

class Skoda : Car {
    init() {
        super.init("Skoda", seats: 7, price: 9)
    }
    
    override class func createCar(with seats: Int)-> Car? {
        return Skoda()
    }
}

class Verna : Car {
    init() {
        super.init("Verna", seats: 8, price: 12)
    }
    
    override class func createCar(with seats: Int)-> Car? {
        return Verna()
    }
}

class CarFactory {
    
    class func makeCar(with seats: Int)-> Car? {
        /*switch seats {
        case 5:
            car = Fortuner()
        case 6:
            car = BMW()
        case 7:
            car = Skoda()
        case 8:
            car = Verna()
        default:
            car = nil
        }
       return car*/
        
        return Car.createCar(with: seats)
    }
}

