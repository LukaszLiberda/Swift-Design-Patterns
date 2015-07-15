//
//  BridgePattern.swift
//  PatternProj
//
//  Created by lukaszliberda on 06.07.2015.
//  Copyright (c) 2015 lukasz. All rights reserved.
//

import Foundation

/*
The bridge pattern is used to separate the abstract elements of a class from the implementation details, providing the means to replace the implementation details without modifying the abstraction.

The bridge pattern is a design pattern used in software engineering which is meant to "decouple an abstraction from its implementation so that the two can vary independently".[1] The bridge uses encapsulation, aggregation, and can use inheritance to separate responsibilities into different classes.

When a class varies often, the features of object-oriented programming become very useful because changes to a program's code can be made easily with minimal prior knowledge about the program. The bridge pattern is useful when both the class and what it does vary often. The class itself can be thought of as the implementation and what the class can do as the abstraction. The bridge pattern can also be thought of as two layers of abstraction.

When there is only one fixed implementation, this pattern is known as the Pimpl idiom in the C++ world.

The bridge pattern is often confused with the adapter pattern. In fact, the bridge pattern is often implemented using the class adapter pattern, e.g. in the Java code below.

Variant: The implementation can be decoupled even more by deferring the presence of the implementation to the point where the abstraction is utilized.

*/


protocol Switch {
    var appliance: Appliance {get set}
    func turnOn()
}

protocol Appliance {
    func run()
}

class RemoteControl: Switch {
    var appliance: Appliance
    
    func turnOn() {
        self.appliance.run()
    }
    
    init(appliance: Appliance) {
        self.appliance = appliance
    }
}

class TV: Appliance {
    func run() {
        println("tv turned on")
    }
}

class VacuumCleaner: Appliance {
    func run() {
        println("vacuum cleaner truned on")
    }
}

/*
usage
*/

class TestBridge {
    func test() {
        var tvRemoteControl = RemoteControl(appliance: TV())
        tvRemoteControl.turnOn()
        
        var fancyVacuumCleanerRemoteControll = RemoteControl(appliance: VacuumCleaner())
        fancyVacuumCleanerRemoteControll.turnOn()
        
        println()
    }
    
    func test2() {
        var stacks: [Stack] = [Stack(s: "java"), Stack(s: "mine"), StackHanoi(s: "java"), StackHanoi(s: "mine")]
        
        for i in 0...19 {
            var num: Int = Int( Int(arc4random_uniform(UInt32(1000))) % 40)
            
            for j in 0...(stacks.count - 1) {
                stacks[j].push(num)
            }
        }
        
        for i in 0...(stacks.count - 1) {
            while !stacks[i].isEmpty() {
                print("\(stacks[i].pop())  ")
            }
            println()
        }
        
        var sh:StackHanoi = stacks[3] as! StackHanoi
        
        println("total rejected id \( sh.reportRejected() )")
        println()
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

protocol StackImp {
    func push(o: AnyObject) -> AnyObject
    func peek() -> AnyObject
    func empty() -> Bool
    func pop() -> AnyObject
}

class  StackJava: StackImp {
    var items: [AnyObject] = []
    var total: Int = -1
    
    func push(o: AnyObject) -> AnyObject {
        items.append(o)
        ++total
        return items
    }
    
    func peek() -> AnyObject {
        return items[total]
    }
    
    func empty() -> Bool {
        return total == -1
    }
    
    func pop() -> AnyObject {
        return items[total--]
    }
}

class StackMine: StackImp {
    var items: [AnyObject] = []
    var total: Int = -1
    
    func push(o: AnyObject) -> AnyObject {
        items.append(o)
        ++total
        return items
    }
    
    func peek() -> AnyObject {
        return items[total]
    }
    
    func pop() -> AnyObject {
        return items[total--]
    }
    
    func empty() -> Bool {
        return total == -1
    }
}



class Stack {
    var imp: StackImp
    init(s: String) {
        if s == "java" {
            imp = StackJava()
        } else {
            imp = StackMine()
        }
    }
    
    func push(i: Int) {
        imp.push(i)
    }
    
    func pop() -> Int {
        return imp.pop().integerValue
    }
    
    func isEmpty() -> Bool {
        return imp.empty()
    }
}

class  StackHanoi: Stack {
    var totalRejected = 0
    
    init() {
        super.init(s: "java")
    }
    
    override init(s: String) {
        super.init(s: s)
    }
    
    func reportRejected() -> Int {
        return totalRejected
    }
    
    override func push(i: Int) {
        if !imp.empty() && i > imp.peek().integerValue {
            totalRejected++
        } else {
            imp.push(i)
        }
    }
}
































