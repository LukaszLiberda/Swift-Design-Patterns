//
//  StrategyPattern.swift
//  PatternProj
//
//  Created by lukaszliberda on 06.07.2015.
//  Copyright (c) 2015 lukasz. All rights reserved.
//

import Foundation

/*
The strategy pattern is used to create an interchangeable family of algorithms from which the required process is chosen at run-time.

In computer programming, the strategy pattern (also known as the policy pattern) is a software design pattern that enables an algorithm's behavior to be selected at runtime. The strategy pattern

defines a family of algorithms,
encapsulates each algorithm, and
makes the algorithms interchangeable within that family.
Strategy lets the algorithm vary independently from clients that use it.[1] Strategy is one of the patterns included in the influential book Design Patterns by Gamma et al. that popularized the concept of using patterns in software design.

For instance, a class that performs validation on incoming data may use a strategy pattern to select a validation algorithm based on the type of data, the source of the data, user choice, or other discriminating factors. These factors are not known for each case until run-time, and may require radically different validation to be performed. The validation strategies, encapsulated separately from the validating object, may be used by other validating objects in different areas of the system (or even different systems) without code duplication.

The essential requirement in the programming language is the ability to store a reference to some code in a data structure and retrieve it. This can be achieved by mechanisms such as the native function pointer, the first-class function, classes or class instances in object-oriented programming languages, or accessing the language implementation's internal storage of code via reflection.
*/


protocol PrintStrategy {
    func printString(string: String) -> String
}

class Printer {
    let strategy: PrintStrategy
    
    func printString(string: String) -> String {
        return self.strategy.printString(string)
    }
    
    init(strategy: PrintStrategy) {
        self.strategy = strategy
    }
}

class UpperCaseStrategy: PrintStrategy {
    func printString(string: String) -> String {
        return string.uppercaseString
    }
}

class LowerCaseStrategy: PrintStrategy {
    func printString(string: String) -> String {
        return string.lowercaseString
    }
}

class TestStrategy {
    func test() {
        var lower = Printer(strategy: LowerCaseStrategy())
        lower.printString("O test Test night Night")
        
        var upper = Printer(strategy: UpperCaseStrategy())
        upper.printString("O test Test night Night")
        println()
    }
    
    func test2() {
        var algoritms:[Strategy] = [Impl1(), Impl2()]
        
        for al in algoritms {
            al.solve()
        }
        println()
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

protocol Strategy {
    func solve()
}

class TemplateMethod1: Strategy {
    func solve() {
        start()
        while nextTry() && !isSolution() {
            
        }
        
        stop()
    }
    
    func start() {
        
    }
    
    func nextTry() -> Bool {
        return false
    }
    
    func isSolution() -> Bool {
        return false
    }
    
    func stop() {
        
    }
}


class Impl1: TemplateMethod1 {
    private var state:Int = 1
    
    override func start() {
        println("start")
    }
    
    override func stop() {
        println("stop")
    }
    
    override func nextTry() -> Bool {
        println("nextTry \(state++)")
        return true
    }
    
    override func isSolution() -> Bool {
        println("isSolution \(state == 3)")
        return (state == 3)
    }
}

class  TemplateMethod2: Strategy {
    func solve() {
        while (true) {
            
        }
    }
    
    func preProcess() {
        
    }
    
    func search() -> Bool {
        return false
    }
    
    func postProcess() {
        
    }
}

class Impl2: TemplateMethod2 {
    private var state: Int = 1
    
    override func preProcess() {
        println("preProcess")
    }
    override func postProcess() {
        println("pstProcess")
    }
    
    override func search() -> Bool {
        println("search state \(state++)")
        return state == 3 ? true : false
    }
}
























