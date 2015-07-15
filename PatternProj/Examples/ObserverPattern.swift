//
//  ObserverPattern.swift
//  PatternProj
//
//  Created by lukaszliberda on 06.07.2015.
//  Copyright (c) 2015 lukasz. All rights reserved.
//

import Foundation

/*
The observer pattern is used to allow an object to publish changes to its state. Other objects subscribe to be immediately notified of any changes.

The observer pattern is a software design pattern in which an object, called the subject, maintains a list of its dependents, called observers, and notifies them automatically of any state changes, usually by calling one of their methods. It is mainly used to implement distributed event handling systems. The Observer pattern is also a key part in the familiar model–view–controller (MVC) architectural pattern.[1] The observer pattern is implemented in numerous programming libraries and systems, including almost all GUI toolkits.

The observer pattern can cause memory leaks, known as the lapsed listener problem, because in basic implementation it requires both explicit registration and explicit deregistration, as in the dispose pattern, because the subject holds strong references to the observers, keeping them alive. This can be prevented by the subject holding weak references to the observers.

*/

protocol PropertyObserver {
    func willChangePropertyName(propertyName: String, newPropertyValue: AnyObject?)
    func didChangePropertyName(propertyName:String, oldPropertyValue: AnyObject?)
}

class TestChambers {
    var observer: PropertyObserver?
    
    var testChamberNumber: Int = 0 {
        willSet(newValue) {
            observer?.willChangePropertyName("testChamberNumber", newPropertyValue: newValue)
        }
        didSet {
            observer?.didChangePropertyName("testChamberNumber", oldPropertyValue: oldValue)
        }
    }
}


class Observer: PropertyObserver {
    func willChangePropertyName(propertyName: String, newPropertyValue: AnyObject?) {
        if newPropertyValue as? Int == 1 {
            println("Okay. Look. We both said a lot of things that you're going to regret.")
        }
    }
    
    func didChangePropertyName(propertyName: String, oldPropertyValue: AnyObject?) {
        if oldPropertyValue as? Int == 0 {
            println("Sorry about the mess. I've really let the place go since you killed me.")
        }
    }
}

/*
usage
*/

class TestObserver {
    func test() {
        var observerInstance = Observer()
        var testChambers = TestChambers()
        
        testChambers.observer = observerInstance
        testChambers.testChamberNumber++
        println()
    }
    
    func test2() {
        var ss: SensorSystem = SensorSystem()
        ss.register(Gates())
        ss.register(Lighting())
        ss.register(Surveillance())
        ss.soundTheAlarm()
        println()
    }
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

protocol AlarmObserver {
    func alarm()
}

class SensorSystem {
    private var observers: [AlarmObserver] = []
    
    func register(al: AlarmObserver) {
        observers.append(al)
    }
    
    func soundTheAlarm() {
        for element in observers {
            element.alarm()
        }
    }
}

class Lighting: AlarmObserver {
    func alarm() {
        println("lights up")
    }
}

class  Gates: AlarmObserver {
    func alarm() {
        println("gates close")
    }
}

class CheckList {
    func byTheNumbers() {
        localize()
        isolate()
        identify()
    }
    
    func localize() {
        println("establish a perimeter")
    }
    
    func isolate() {
        println("isolate the grid")
    }
    
    func identify() {
        println("identify the source")
    }
}


class Surveillance: CheckList, AlarmObserver {
    func alarm() {
        println("Surveillance - by the number:")
        byTheNumbers()
    }
    
    override func isolate() {
        println("train the cameras")
    }
}


















