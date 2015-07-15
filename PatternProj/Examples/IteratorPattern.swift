//
//  IteratorPattern.swift
//  PatternProj
//
//  Created by lukasz on 06/07/15.
//  Copyright (c) 2015 lukasz. All rights reserved.
//

import Foundation
import Swift
import UIKit

/*
The iterator pattern is used to provide a standard interface for traversing a collection of items in an aggregate object without the need to understand its underlying structure.

In object-oriented programming, the iterator pattern is a design pattern in which an iterator is used to traverse a container and access the container's elements. The iterator pattern decouples algorithms from containers; in some cases, algorithms are necessarily container-specific and thus cannot be decoupled.

For example, the hypothetical algorithm SearchForElement can be implemented generally using a specified type of iterator rather than implementing it as a container-specific algorithm. This allows SearchForElement to be used on any container that supports the required type of iterator.

*/

struct NovellasCollection<T> {
    let novellas: [T]
}

extension NovellasCollection: SequenceType {
    typealias Generator = GeneratorOf<T>
    
    func generate() -> GeneratorOf<T> {
        var i = 0
        return GeneratorOf { return i >= self.novellas.count ? nil : self.novellas[i++]}
    }
}

/*
usage
*/
class TestIterator {
    func test() {
        let greatNovellas = NovellasCollection(novellas:["Dark", "White"])

        for novella in greatNovellas {
            println("I have read: \(novella)")
        }
        println()
    }
    
    func test2() {
        var ca: ConcreteAggregate = ConcreteAggregate()
        ca[0] = "Item A"
        ca[1] = "Item B"
        ca[2] = "Item C"
        ca[3] = "Item D"
        
        var ci:ConcreteIterator = ConcreteIterator(aggregate: ca)
        println("Iterating collection")
        
        var item:String? = ci.first() as? String
        
        while item != nil {
            println("\(item)")
            item = ci.next() as? String
        }
        
        println()
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

protocol Iterator {
    func first() -> AnyObject
    func next() -> AnyObject?
    func isDone() -> Bool
    func currentItem() -> AnyObject
}

protocol Aggregate {
    func createIterator() -> Iterator
}

class ConcreteAggregate: Aggregate {
    private var items: [AnyObject] = []
    
    func createIterator() -> Iterator {
        return ConcreteIterator(aggregate: self)
    }
    
    var countItems:Int {
        get {
            return items.count
        }
    }
    
    subscript(index: Int) -> AnyObject {
        get {
            return items[index]
        }
        set(newItem) {
           items.append(newItem)
        }
    }
    
}

class ConcreteIterator: Iterator {
    private var aggregate: ConcreteAggregate
    private var current: Int = 0
    
    init(aggregate: ConcreteAggregate) {
        self.aggregate = aggregate
    }
    
    func first() -> AnyObject {
        return aggregate[0]
    }
    
    func next() -> AnyObject? {
        var ret:AnyObject?
        
        if current < aggregate.countItems - 1 {
            ret = aggregate[++current]
        }
        
        return ret
    }
    
    func currentItem() -> AnyObject {
        return aggregate[current]
    }
    
    func isDone() -> Bool {
        return current >= aggregate.countItems ? true : false
    }
    
    
}









