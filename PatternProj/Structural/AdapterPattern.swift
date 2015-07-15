//
//  AdapterPattern.swift
//  PatternProj
//
//  Created by lukaszliberda on 06.07.2015.
//  Copyright (c) 2015 lukasz. All rights reserved.
//

import Foundation

/*
In software engineering, structural design patterns are design patterns that ease the design by identifying a simple way to realize relationships between entities.



The adapter pattern is used to provide a link between two otherwise incompatible types by wrapping the "adaptee" with a class that supports the interface required by the client.

In software engineering, the adapter pattern is a software design pattern that allows the interface of an existing class to be used from another interface.[1] It is often used to make existing classes work with others without modifying their source code.

*/


protocol OlderDeathStarSuperLaserAiming {
    var angleV: NSNumber {get}
    var angleH: NSNumber {get}
}

// Adaptee

struct DeathStarSuperLaserTarget {
    let angleHorizontal: Double
    let angleVertical: Double
    
    init(angleHorizontal: Double, angleVertical: Double) {
        self.angleHorizontal = angleHorizontal
        self.angleVertical = angleVertical
    }
}

// Adapter

struct OldDeathStarSuperLaserTarget: OlderDeathStarSuperLaserAiming {
    private let target: DeathStarSuperLaserTarget
    
    var angleV: NSNumber {
        return NSNumber(double: target.angleVertical)
    }
    
    var angleH: NSNumber {
        return NSNumber(double: target.angleHorizontal)
    }
    
    init(_ target: DeathStarSuperLaserTarget) {
        self.target = target
    }
}

/*
usage
*/

class TestAdapter {
    func test() {
        let target = DeathStarSuperLaserTarget(angleHorizontal: 14.0, angleVertical: 12.0)
        let oldFormat = OldDeathStarSuperLaserTarget(target)
        
        oldFormat.angleH
        oldFormat.angleV
        println()
    }
    
    func test2() {
        var rh: RoundHole = RoundHole(r: 5)
        var spa: SquarePegAdapter
        
        for i in 6...9 {
            spa = SquarePegAdapter(w: Double(i))
            spa.makeFit(rh)
        }
        println()
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class SquarePeg {
    var width: Double
    
    init(w: Double) {
        width = w
    }
}

class RoundHole {
    var radius: Int
    
    init(r: Int) {
        radius = r
    }
    
    func roundHole(r: Int) {
        radius = r
    }
}

class SquarePegAdapter {
    var sp: SquarePeg
    
    init(w: Double) {
        sp = SquarePeg(w: w)
    }
    
    func makeFit(rh: RoundHole) {
        var amount: Double = sp.width - Double(rh.radius) * sqrt(2)
        println("amount \(amount)")
        
        if amount > 0 {
            sp.width -= amount
        }
    }
}





































