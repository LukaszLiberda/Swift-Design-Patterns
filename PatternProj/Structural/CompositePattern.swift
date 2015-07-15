//
//  CompositePattern.swift
//  PatternProj
//
//  Created by lukaszliberda on 06.07.2015.
//  Copyright (c) 2015 lukasz. All rights reserved.
//

import Foundation

/*
The composite pattern is used to create hierarchical, recursive tree structures of related objects where any element of the structure may be accessed and utilised in a standard manner.

In software engineering, the composite pattern is a partitioning design pattern. The composite pattern describes that a group of objects is to be treated in the same way as a single instance of an object. The intent of a composite is to "compose" objects into tree structures to represent part-whole hierarchies. Implementing the composite pattern lets clients treat individual objects and compositions uniformly.[1]

*/

protocol Shape {
    func draw(fillColor: String)
}

// Leafs

class Square: Shape {
    func draw(fillColor: String) {
        println("Drawing a Square with color \(fillColor)")
    }
}

class Circle: Shape {
    func draw(fillColor: String) {
        println("Drawing a circle with color \(fillColor)")
    }
}

// Composite

class Whiteboard: Shape {
    lazy var shapes = [Shape]()
    
    init(_ shapes: Shape...) {
        self.shapes = shapes
    }
    
    func draw(fillColor: String) {
        for shape in self.shapes {
            shape.draw(fillColor)
        }
    }
}

/*
usage
*/

class TestComposite {
    func test() {
        var whiteboard = Whiteboard(Circle(), Square())
        whiteboard.draw("Red")
        println()
    }
    
    func test2() {
        var root: Composite = Composite(name: "root")
        root.add(Leaf(name: "Leaf A"))
        root.add(Leaf(name: "Leaf B"))
        
        var comp: Composite = Composite(name: "Composite X")
        comp.add(Leaf(name: "Leaf XA"))
        comp.add(Leaf(name: "Leaf XB"))
        
        root.add(comp)
        root.add(Leaf(name: "Leaf C"))
        
        var leaf: Leaf = Leaf(name: "Leaf D")
        root.add(leaf)
        root.remove(leaf)
        
        root.display(1)
        println()
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class Component {
    var name: String
    
    init(name:String) {
        self.name = name
    }
    
    func add(c: Component) {}
    func remove(c: Component) {}
    func display(depth:Int) {}
}

class Composite: Component {
    var children: [Component] = []
    
    override init(name: String) {
        super.init(name: name)
    }
    
    override func add(c: Component) {
        children.append(c)
    }
    
    override func remove(c: Component) {
        var index = 0
        for elm in self.children {
            if elm.name == c.name {
                self.children.removeAtIndex(index)
                return
            }
            index++
        }
    }
    
    override func display(depth: Int) {
        var str = "-".repeatString(depth)
        println("\(str) \(depth) + \(name)")
        
        for c in children {
            c.display(depth + 2)
        }
    }
}


class Leaf: Component {
    override init(name:String) {
        super.init(name: name)
    }
    
    override func add(c: Component) {
        println("Cannot add to leaf")
    }
    
    override func remove(c: Component) {
        println("Cannot remove from leaf")
    }
    
    override func display(depth: Int) {
        var str = "-".repeatString(depth)
        println("\(str) \(depth) + \(name)")
    }
}

extension String {
    func repeatString(n: Int) -> String {
        return "".join(Array(count: n, repeatedValue: self))
    }
}















