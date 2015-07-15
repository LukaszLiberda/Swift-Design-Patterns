//
//  FactoryMethodPattern.swift
//  PatternProj
//
//  Created by lukaszliberda on 06.07.2015.
//  Copyright (c) 2015 lukasz. All rights reserved.
//

import Foundation

/*
The factory pattern is used to replace class constructors, abstracting the process of object generation so that the type of the object instantiated can be determined at run-time.

In class-based programming, the factory method pattern is a creational pattern which uses factory methods to deal with the problem of creating objects without specifying the exact class of object that will be created. This is done by creating objects via calling a factory method—either specified in an interface and implemented by child classes, or implemented in a base class and optionally overridden by derived classes—rather than by calling a constructor.


*/

protocol Currency {
    func symbol() -> String
    func code() -> String
}

class Euro: Currency {
    func symbol() -> String {
        return "€"
    }
    
    func code() -> String {
        return "EUR"
    }
}

class UnitedStatesDolar: Currency {
    func symbol() -> String {
        return "$"
    }
    
    func code() -> String {
        return "USD"
    }
}

enum Country {
    case UnitedStates, Spain, France, UK
}

class CurrencyFactory {
    class func currencyForCountry(country: Country) -> Currency? {
        switch country {
            case .Spain, .France:
                return Euro()
            case .UnitedStates:
                return UnitedStatesDolar()
            default:
            return nil
        }
    }
}

/*
usage
*/

class TestFactoryMethods {
    func test() {
        let noCurrencyCode = "No Currency Code Available"
        
        CurrencyFactory.currencyForCountry(Country.Spain)?.code() ?? noCurrencyCode
        CurrencyFactory.currencyForCountry(Country.UnitedStates)?.code() ?? noCurrencyCode
        CurrencyFactory.currencyForCountry(Country.France)?.code() ?? noCurrencyCode
        CurrencyFactory.currencyForCountry(Country.UK)?.code() ?? noCurrencyCode
        println()
    }
    
    func test2() {
        var creators: [Creator] = []
        
        creators.append(ConcreteCreatorA())
        creators.append(ConcreteCreatorB())
        
        for creator in creators {
            var product: Product = creator.FactoryMethod()
            product.detailsPrint()
        }
        println()
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


protocol Product {
    func detailsPrint()
}

class ConcreteProductA: Product {
    func detailsPrint() {
        println("Product A")
    }
}

class ConcreteProductB: Product {
    func detailsPrint() {
        println("Product B")
    }
}

protocol Creator {
    func FactoryMethod() -> Product
}

class ConcreteCreatorA: Creator {
    func FactoryMethod() -> Product {
        return ConcreteProductA()
    }
}

class ConcreteCreatorB: Creator {
    func FactoryMethod() -> Product {
        return ConcreteProductB()
    }
}






































