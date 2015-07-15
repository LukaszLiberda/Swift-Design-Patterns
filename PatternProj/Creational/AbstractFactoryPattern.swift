//
//  AbstractFactoryPattern.swift
//  PatternProj
//
//  Created by lukaszliberda on 06.07.2015.
//  Copyright (c) 2015 lukasz. All rights reserved.
//

import Foundation

/*
Creational patterns are ones that create objects for you, rather than having you instantiate objects directly. This gives your program more flexibility in deciding which objects need to be created for a given case.

In software engineering, creational design patterns are design patterns that deal with object creation mechanisms, trying to create objects in a manner suitable to the situation. The basic form of object creation could result in design problems or added complexity to the design. Creational design patterns solve this problem by somehow controlling this object creation.

The abstract factory pattern is used to provide a client with a set of related or dependant objects. The "family" of objects created by the factory are determined at run-time.



The abstract factory pattern provides a way to encapsulate a group of individual factories that have a common theme without specifying their concrete classes.[1] In normal usage, the client software creates a concrete implementation of the abstract factory and then uses the generic interface of the factory to create the concrete objects that are part of the theme. The client doesn't know (or care) which concrete objects it gets from each of these internal factories, since it uses only the generic interfaces of their products.[1] This pattern separates the details of implementation of a set of objects from their general usage and relies on object composition, as object creation is implemented in methods exposed in the factory interface.[2]

An example of this would be an abstract factory class DocumentCreator that provides interfaces to create a number of products (e.g. createLetter() and createResume()). The system would have any number of derived concrete versions of the DocumentCreator class like FancyDocumentCreator or ModernDocumentCreator, each with a different implementation of createLetter() and createResume() that would create a corresponding object like FancyLetter or ModernResume. Each of these products is derived from a simple abstract class like Letter or Resume of which the client is aware. The client code would get an appropriate instance of the DocumentCreator and call its factory methods. Each of the resulting objects would be created from the same DocumentCreator implementation and would share a common theme (they would all be fancy or modern objects). The client would only need to know how to handle the abstract Letter or Resume class, not the specific version that it got from the concrete factory.

A factory is the location of a concrete class in the code at which objects are constructed. The intent in employing the pattern is to insulate the creation of objects from their usage and to create families of related objects without having to depend on their concrete classes.[2] This allows for new derived types to be introduced with no change to the code that uses the base class.

Use of this pattern makes it possible to interchange concrete implementations without changing the code that uses them, even at runtime. However, employment of this pattern, as with similar design patterns, may result in unnecessary complexity and extra work in the initial writing of code. Additionally, higher levels of separation and abstraction can result in systems which are more difficult to debug and maintain.

*/

// protocol

protocol Decimal {
    func stringValue() -> String
}

protocol NumberFactoryProtocol {
    func numberFromString(string: String) -> Decimal
}

struct NextStepNumber: Decimal {
    private var nextStepNumber: NSNumber
    
    func stringValue() -> String {
        return "\(nextStepNumber.stringValue)"
    }
}

struct SwiftNumber: Decimal {
    private var swiftInt: Int
    
    func stringValue() -> String {
        return "\(swiftInt)"
    }
}

// factories

class NextStepNumberFactory: NumberFactoryProtocol {
    func numberFromString(string: String) -> Decimal {
        return NextStepNumber(nextStepNumber: NSNumber(longLong: (string as NSString).longLongValue))
    }
}

class  SwiftNumberFactory: NumberFactoryProtocol {
    func numberFromString(string: String) -> Decimal {
        return SwiftNumber(swiftInt: (string as NSString).integerValue)
    }
}

// Abstract factory

enum NumberType {
    case NextStep, Swift
}

class NumberAbstractFactory {
    class func numberFactoryType(type: NumberType) -> NumberFactoryProtocol {
        switch type {
            case .NextStep:
                return NextStepNumberFactory()
            case .Swift:
                return SwiftNumberFactory()
        }
    }
}

/*
usage
*/

class TestAbstractFactory {
    
    func test() {
        let factoryOne = NumberAbstractFactory.numberFactoryType(NumberType.NextStep)
        let numberOne = factoryOne.numberFromString("1")
        println("\(numberOne.stringValue())")
        
        let factoryTwo = NumberAbstractFactory.numberFactoryType(NumberType.Swift)
        let numberTwo = factoryTwo.numberFromString("2")
        println("\(numberTwo.stringValue())")
        println()
    }
    
    func test2() {
        var factory1: SAbstractFactory = ConcreteFactory1()
        var c1: Client = Client(factory: factory1)
        c1.run()
        
        var factory2: SAbstractFactory = ConcreteFactory2()
        var c2: Client = Client(factory: factory2)
        c2.run()
        println()
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

protocol SAbstractProductA {
    
}

protocol SAbstractProductB {
    func Interact(productA: SAbstractProductA)
}

class ProductA1: SAbstractProductA {
    
}

class ProductB1: SAbstractProductB {
    func Interact(productA: SAbstractProductA) {
        println("\(self) interacts with \(productA.self)")
    }
}

class ProductA2: SAbstractProductA {
    
}

class ProductB2: SAbstractProductB {
    func Interact(productA: SAbstractProductA) {
        println("\(self) interacts with \(productA.self)")
    }
}

//////


protocol SAbstractFactory {
    func CreateProductA() -> SAbstractProductA
    func CreateProductB() -> SAbstractProductB
}

class ConcreteFactory1: SAbstractFactory {
    func CreateProductA() -> SAbstractProductA {
        return ProductA1()
    }
    
    func CreateProductB() -> SAbstractProductB {
        return ProductB1()
    }
}

class ConcreteFactory2: SAbstractFactory {
    func CreateProductA() -> SAbstractProductA {
        return ProductA2()
    }
    
    func CreateProductB() -> SAbstractProductB {
        return ProductB2()
    }
}

/////
class Client {
    private var abstractProductA: SAbstractProductA
    private var abstractProductB: SAbstractProductB
    
    init(factory: SAbstractFactory) {
        abstractProductA = factory.CreateProductA()
        abstractProductB = factory.CreateProductB()
    }
    
    func run() {
        abstractProductB.Interact(abstractProductA)
    }
}














