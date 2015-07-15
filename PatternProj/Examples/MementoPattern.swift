//
//  MementoPattern.swift
//  PatternProj
//
//  Created by lukasz on 06/07/15.
//  Copyright (c) 2015 lukasz. All rights reserved.
//

import Foundation
import UIKit

/*
The memento pattern is used to capture the current state of an object and store it in such a manner that it can be restored at a later time without breaking the rules of encapsulation.

The memento pattern is a software design pattern that provides the ability to restore an object to its previous state (undo via rollback).

The memento pattern is implemented with three objects: the originator, a caretaker and a memento. The originator is some object that has an internal state. The caretaker is going to do something to the originator, but wants to be able to undo the change. The caretaker first asks the originator for a memento object. Then it does whatever operation (or sequence of operations) it was going to do. To roll back to the state before the operations, it returns the memento object to the originator. The memento object itself is an opaque object (one which the caretaker cannot, or should not, change). When using this pattern, care should be taken if the originator may change other objects or resources - the memento pattern operates on a single object.

Classic examples of the memento pattern include the seed of a pseudorandom number generator (it will always produce the same sequence thereafter when initialized with the seed state)[citation needed][clarification needed] and the state in a finite state machine.

*/

typealias Memento = Dictionary<NSObject, AnyObject>

let DPMementoKeyChapter = "com.value.halflife.chapter"
let DPMementoKeyWeapon = "com.value.halflife.weapon"
let DPMementoGameState = "com.value.halflife.state"

// originator

class GameState {
    var chapter: String = ""
    var weapon: String = ""
    
    func toMemento() -> Memento {
        return [DPMementoKeyChapter: chapter, DPMementoKeyWeapon: weapon]
    }
    
    func restoreFromMemento(memento: Memento) {
        chapter = memento[DPMementoKeyChapter] as? String ?? "n/a"
        weapon = memento[DPMementoKeyWeapon] as? String ?? "n/a"
    }
}

// caretaker

class CheckPoint {
    class func saveState(memento: Memento, keyName: String = DPMementoGameState) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(memento, forKey: keyName)
        defaults.synchronize()
    }
    
    class func restorePreviousState(keyName: String = DPMementoGameState) -> Memento {
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.objectForKey(keyName) as? Memento ?? Memento()
    }
}

/*
usage
*/

class TestMemento {
    func test() {
        var gameState = GameState()
        gameState.restoreFromMemento(CheckPoint.restorePreviousState())
        
        gameState.chapter = "Black mess"
        gameState.weapon = "Crow"
        CheckPoint.saveState(gameState.toMemento())
        
        gameState.chapter = "anomalous Materials"
        gameState.weapon = "Glock 17"
        gameState.restoreFromMemento(CheckPoint.restorePreviousState())
        
        gameState.chapter = "Unforeseen Consequences"
        gameState.weapon = "MP5"
        CheckPoint.saveState(gameState.toMemento(), keyName: "gameState2")
        
        gameState.chapter = "Office complex"
        gameState.weapon = "Crossbow"
        CheckPoint.saveState(gameState.toMemento())
        
        gameState.restoreFromMemento(CheckPoint.restorePreviousState(keyName: "gameState2"))
        println()
    }
    
    func test2() {
        var caretaker:Caretaker = Caretaker()
        var originator:Originator = Originator()
        
        originator.state("State1")
        originator.state("State2")
        caretaker.addMemento(originator.saveToMemento())
        
        originator.state("State3")
        caretaker.addMemento(originator.saveToMemento())
        originator.state("State4")
        originator.restoreFromMemento(caretaker.memento(1))
        println()
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class MementoClass {
    private var state: String
    
    init(stateToSave: String) {
        state = stateToSave
    }
    
    func savedState() -> String {
        return state
    }
}

class Originator {
    private var state: String?
    
    func state(stateString:String) {
        println("Originator set state to \(stateString)")
        state = stateString
    }
    
    func saveToMemento() -> MementoClass {
        println("save to memento")
        return MementoClass(stateToSave: state!)
    }
    
    func restoreFromMemento(me: MementoClass) {
        state = me.savedState()
        println("state after resoring from mmento \(state)")
    }
}

class Caretaker {
    private var saveStates: [MementoClass] = []
    
    func addMemento(me: MementoClass) {
        saveStates.append(me)
    }
    
    func memento(index:Int) -> MementoClass {
        return saveStates[index]
    }
}











