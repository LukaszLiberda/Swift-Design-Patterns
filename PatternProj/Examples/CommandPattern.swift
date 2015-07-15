//
//  CommandPattern.swift
//  PatternProj
//
//  Created by lukasz on 05/07/15.
//  Copyright (c) 2015 lukasz. All rights reserved.
//

import Foundation

/*
The command pattern is used to express a request, including the call to be made and all of its required parameters, in a command object. The command may then be executed immediately or held for later use.

In object-oriented programming, the command pattern is a behavioral design pattern in which an object is used to encapsulate all information needed to perform an action or trigger an event at a later time. This information includes the method name, the object that owns the method and values for the method parameters.

Four terms always associated with the command pattern are command, receiver, invoker and client. A command object knows about receiver and invokes a method of the receiver. Values for parameters of the receiver method are stored in the command. The receiver then does the work. An invoker object knows how to execute a command, and optionally does bookkeeping about the command execution. The invoker does not know anything about a concrete command, it knows only about command interface. Both an invoker object and several command objects are held by a client object. The client decides which commands to execute at which points. To execute a command, it passes the command object to the invoker object.

Using command objects makes it easier to construct general components that need to delegate, sequence or execute method calls at a time of their choosing without the need to know the class of the method or the method parameters. Using an invoker object allows bookkeeping about command executions to be conveniently performed, as well as implementing different modes for commands, which are managed by the invoker object, without the need for the client to be aware of the existence of bookkeeping or modes.
*/

protocol DoorBehaviore {
    func execute() -> String
}

class OpenCommand: DoorBehaviore {
    let doors: String
    
    required init(doors: String) {
        self.doors = doors
    }
    
    func execute() -> String {
        return "Opened \(doors)"
    }
}

class CloseCommand: DoorBehaviore {
    let doors: String
    
    required init(doors: String) {
        self.doors = doors
    }
    
    func execute() -> String {
        return "Closed \(doors)"
    }
}

class DoorsOperations {
    let openCommand: DoorBehaviore
    let closeCommand: DoorBehaviore
    
    init(doors: String) {
        self.openCommand = OpenCommand(doors: doors)
        self.closeCommand = CloseCommand(doors: doors)
    }
    
    func close() -> String {
        return closeCommand.execute()
    }
    
    func open() -> String {
        return openCommand.execute()
    }
}


/*
usage
*/
class TestCommand {
    func test() {
        let doors = "matrix doors"
        let doorModule = DoorsOperations(doors: doors)
        doorModule.open()
        doorModule.close()
        println()
    }
    
    func test2() {
        var queue: [Command] = []
        queue.append(DomesticEngineer())
        queue.append(Politician())
        queue.append(Programmer())
        
        for it in queue {
            it.execute()
        }
        println()
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

protocol Command {
    func execute()
}

class DomesticEngineer: Command {
    func execute() {
        println("take out the trash")
    }
}

class Politician: Command {
    func execute() {
        println("take money from the rich, take votes from the poor")
    }
}

class Programmer: Command {
    func execute() {
        println("sell the bugs, charge extra for the fixes")
    }
}

















