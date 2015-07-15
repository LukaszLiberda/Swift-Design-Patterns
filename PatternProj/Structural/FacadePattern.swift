//
//  FacadePattern.swift
//  PatternProj
//
//  Created by lukaszliberda on 06.07.2015.
//  Copyright (c) 2015 lukasz. All rights reserved.
//

import Foundation


/*
The facade pattern is used to define a simplified interface to a more complex subsystem.

The facade pattern (or façade pattern) is a software design pattern commonly used with object-oriented programming. The name is by analogy to an architectural facade.

A facade is an object that provides a simplified interface to a larger body of code, such as a class library. A facade can:

make a software library easier to use, understand and test, since the facade has convenient methods for common tasks;
make the library more readable, for the same reason;
reduce dependencies of outside code on the inner workings of a library, since most code uses the facade, thus allowing more flexibility in developing the system;
wrap a poorly designed collection of APIs with a single well-designed API (as per task needs).
The Facade design pattern is often used when a system is very complex or difficult to understand because the system has a large number of interdependent classes or its source code is unavailable. This pattern hides the complexities of the larger system and provides a simpler interface to the client. It typically involves a single wrapper class which contains a set of members required by client. These members access the system on behalf of the facade client and hide the implementation details.

*/

class  Eternal {
    class func setObject(value: AnyObject!, forKey defaultName: String!) {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(value, forKey: defaultName)
        defaults.synchronize()
    }
    
    class  func objectForKey(defaultName: String!) -> AnyObject! {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        return defaults.objectForKey(defaultName)
    }
}

/*
usage
*/
class TestFacade {
    func test() {
        Eternal.setObject("Disconnect me. I'd rather be nothing", forKey: "Bishop")
        Eternal.objectForKey("Bishop")
        println()
    }
    
    func test2() {
        println()
        var line1: Line = Line(ori: Point(xx: 2, yy: 4), end: Point(xx: 5, yy: 7))
        line1.move(-2, dy: -4)
        println("after move: \(line1.toString())")
        line1.rotate(45)
        println("after rotate: \(line1.toString())")
        var line2: Line = Line(ori: Point(xx: 2, yy: 1), end: Point(xx: 2.866, yy: 1.5))
        line2.rotate(30)
        println("30 degrees to 60 degrees \(line2.toString())")
        println()
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class PointCarte {
    var x, y : Double
    
    init(xx: Double, yy: Double) {
        x = xx
        y = yy
    }
    
    func move(#dx: Int, dy: Int) {
        x += Double(dx)
        y += Double(dy)
    }
    
    func toStrinng() -> String {
        return "\(x), \(y)"
    }
}

class PointPolar {
    var radius, angle: Double
    
    init(r: Double, a: Double) {
        radius = r
        angle = a
    }
    
    func rotate(ang: Int) {
        angle += Double(ang % 360)
    }
    
    func toString() -> String {
        return "[\(radius)@\(angle)]"
    }
}

class Point {
    var pc: PointCarte
    
    init(xx: Double, yy: Double) {
        pc = PointCarte(xx: xx, yy: yy)
    }
    
    func toString() -> String {
        return pc.toStrinng()
    }
    
    func move(#dx: Int, dy: Int) {
        pc.move(dx: dx, dy: dy)
    }
    
    func rotate(angle: Int, o: Point) {
        var x = pc.x - o.pc.x
        var y = pc.y - o.pc.y
        
        var pp: PointPolar = PointPolar(r: sqrt(x*x+y*y), a: atan2(x, y)*180 / M_PI)
        
        pp.rotate(angle)
        println("Point polar is \(pp.toString())")
        
        var str = pp.toString()
        
        var i = str.rangeOfString("@")!.startIndex
        var i1 = advance(str.startIndex, 1)
        var i2 = advance(str.rangeOfString("]")!.startIndex, -1)
        var rg: Range = Range(start:i1, end:i)
        
        var rg2: Range = Range(start:advance(i, 1), end:i2)
        
        var r: Double = str.substringWithRange(rg).toDouble()!
        var a: Double = str.substringWithRange(rg2).toDouble()!
        
        pc = PointCarte(xx: r * cos(a * M_PI / 180) + o.pc.x , yy: r * sin(a * M_PI / 180) + o.pc.y)
        
    }
}

class Line {
    var o, e: Point
    
    init(ori: Point, end: Point) {
        o = ori
        e = end
    }
    
    func move(dx: Int, dy: Int) {
        o.move(dx: dx, dy: dy)
        e.move(dx: dx, dy: dy)
    }
    
    func rotate(angle: Int) {
        e.rotate(angle, o: o)
    }
    
    func toString() -> String {
        return "origin is \(o.toString()), end is \(e.toString())"
    }
}

extension String {
    func toDouble() -> Double? {
        return NSNumberFormatter().numberFromString(self)?.doubleValue
    }
}







































