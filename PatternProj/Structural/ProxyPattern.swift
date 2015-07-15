//
//  ProxyPattern.swift
//  PatternProj
//
//  Created by lukaszliberda on 06.07.2015.
//  Copyright (c) 2015 lukasz. All rights reserved.
//

import Foundation

/*
The proxy pattern is used to provide a surrogate or placeholder object, which references an underlying object. Protection proxy is restricting access.

In computer programming, the proxy pattern is a software design pattern.

A proxy, in its most general form, is a class functioning as an interface to something else. The proxy could interface to anything: a network connection, a large object in memory, a file, or some other resource that is expensive or impossible to duplicate.

A well-known example of the proxy pattern is a reference counting pointer object.

In situations where multiple copies of a complex object must exist, the proxy pattern can be adapted to incorporate the flyweight pattern in order to reduce the application's memory footprint. Typically, one instance of the complex object and multiple proxy objects are created, all of which contain a reference to the single original complex object. Any operations performed on the proxies are forwarded to the original object. Once all instances of the proxy are out of scope, the complex object's memory may be deallocated.

*/


protocol DoorOperator {
    func openDoors(doors: String) -> String
}

class HPF: DoorOperator {
    func openDoors(doors: String) -> String {
        return ("HPF: affirmativ, I read you. Opened \(doors).")
    }
}

class CurrentComputer: DoorOperator {
    private var computer: HPF!
    
    func authenticateWithPassword(pass: String) -> Bool {
        if pass != "pass" {
            return false
        }
        
        computer = HPF()
        return true
    }
    
    func openDoors(doors: String) -> String {
        if computer == nil {
            return "Access Denied, I'm afraid I can't do that"
        }
        
        return computer.openDoors(doors)
    }
}


/*
usage
*/

class TestProxy {
    func test() {
        let computer = CurrentComputer()
        let doors = "Pod Bay Doors"
        
        computer.openDoors(doors)
        computer.authenticateWithPassword("pass")
        computer.openDoors(doors)
        println()
    }
    
    func test2() {
        var proxy: Proxy = Proxy()
        proxy.Request()
        println()
    }
    
    func test3() {
        var hCash: HandyCash = HandyCash()
        var worker: [Person] = [Person(), Person(), Person(), Person()]
        
        var amount: Int = 100
        
        for i in 0...3 {
            amount += 100
            
            if !hCash.withDraw(worker[i], amount: amount) {
                println("No money for \(worker[i].nameString)")
            } else {
                println("\(amount) dollars for \(worker[i].nameString)")
            }
            
            println("Balance is \(hCash.realMoney)")
        }
        println()
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

protocol Subject {
    func Request()
}

class RealSubject: Subject {
    func Request() {
        println("called reqest in RealSubject")
    }
}

class Proxy: Subject {
    private var realSubject: RealSubject?
    
    func Request() {
        if realSubject == nil {
            realSubject = RealSubject()
        }
        realSubject?.Request()
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class Person {
    var nameString:String
    static var list: [String] = {
        return ["Tom", "John", "Harry", "Mary"]
    }()
    
    static var next: Int = 0
    
    init() {
        nameString = Person.list[Person.next++]
    }
}

class HandyCashProtected {
    var balance: Int
    
    init() {
        self.balance = 500
    }
    
    func withDraw(amount:Int) -> Bool {
        if amount > balance {
            return false
        }
        
        balance -= amount
        return true
    }
}

class HandyCash {
    var realMoney: HandyCashProtected = HandyCashProtected()
    
    func withDraw(person: Person, amount: Int) -> Bool {
        if person.nameString == "Tom" || person.nameString == "Mary" || person.nameString == "John" {
            return realMoney.withDraw(amount)
        } else {
            return false
        }
    }
}
























