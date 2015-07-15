//
//  MediatorPattern.swift
//  PatternProj
//
//  Created by lukasz on 06/07/15.
//  Copyright (c) 2015 lukasz. All rights reserved.
//

import Foundation

/*
The mediator pattern is used to reduce coupling between classes that communicate with each other. Instead of classes communicating directly, and thus requiring knowledge of their implementation, the classes send messages via a mediator object.

In Software Engineering, the mediator pattern defines an object that encapsulates how a set of objects interact. This pattern is considered to be a behavioral pattern due to the way it can alter the program's running behavior.

Usually a program is made up of a large number of classes. So the logic and computation is distributed among these classes. However, as more classes are developed in a program, especially during maintenance and/or refactoring, the problem of communication between these classes may become more complex. This makes the program harder to read and maintain. Furthermore, it can become difficult to change the program, since any change may affect code in several other classes.

With the mediator pattern, communication between objects is encapsulated with a mediator object. Objects no longer communicate directly with each other, but instead communicate through the mediator. This reduces the dependencies between communicating objects, thereby lowering the coupling.

*/

class Colleague {
    let mediator: Mediator
    
    init(mediator: Mediator) {
        self.mediator = mediator
    }
    
    func send(message: String) {
        mediator.send(message, colleague: self)
    }
    
    func receive(message: String) {
        assert(false, "Method should be overriden")
    }
}

protocol Mediator {
    func send(message: String, colleague: Colleague)
}

class MessageMediator: Mediator {
    private var colleagues: [Colleague] = []
    
    func addColleague(colleague: Colleague) {
        colleagues.append(colleague)
    }
    
    func send(message: String, colleague: Colleague) {
        for c in colleagues {
            if c !== colleague {
                colleague.receive(message)
            }
        }
    }
}

class ConcreteColleague: Colleague {
    override func receive(message: String) {
        println("Colleague received: \(message)")
    }
}

/*
usage
*/

class TestMediator {
    func test() {
        let messagesMegiator = MessageMediator()
        let user0 = ConcreteColleague(mediator: messagesMegiator)
        let user1 = ConcreteColleague(mediator: messagesMegiator)
        
        messagesMegiator.addColleague(user0)
        messagesMegiator.addColleague(user1)
        
        user0.send("Hello")
        println()
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////



















