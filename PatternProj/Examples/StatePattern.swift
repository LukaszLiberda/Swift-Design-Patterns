//
//  StatePattern.swift
//  PatternProj
//
//  Created by lukaszliberda on 06.07.2015.
//  Copyright (c) 2015 lukasz. All rights reserved.
//

import Foundation

/*
https://en.wikipedia.org/wiki/Design_Patterns

The state pattern is used to alter the behaviour of an object as its internal state changes. The pattern allows the class for an object to apparently change at run-time.

The state pattern, which closely resembles Strategy Pattern, is a behavioral software design pattern, also known as the objects for states pattern. This pattern is used in computer programming to encapsulate varying behavior for the same object based on its internal state. This can be a cleaner way for an object to change its behavior at runtime without resorting to large monolithic conditional statements[1]:395 and thus improve maintainability.[2]

*/

class Context {
    private var state: State = UnauthorizedState()
    
    var isAuthorized: Bool {
        get { return state.isAuthorized(self)}
    }
    
    var userId: String? {
        get { return state.userId(self)}
    }
    
    func changeStateToAuthorized(#userId: String) {
        state = AuthorizedState(userId: userId)
    }
    
    func changeStateToUnauthorized() {
        state = UnauthorizedState()
    }
}

protocol State {
    func isAuthorized(context: Context) -> Bool
    func userId(context: Context) -> String?
}

class UnauthorizedState: State {
    func isAuthorized(context: Context) -> Bool {
        return false
    }
    func userId(context: Context) -> String? {
        return nil
    }
}

class  AuthorizedState: State {
    let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    func isAuthorized(context: Context) -> Bool {
        return true
    }
    
    func userId(context: Context) -> String? {
        return userId
    }
}

/*
usage
*/

class TestState {
    func test() {
        let context = Context()
        (context.isAuthorized, context.userId)
        context.changeStateToAuthorized(userId: "admin")
        (context.isAuthorized, context.userId)
        context.changeStateToUnauthorized()
        (context.isAuthorized, context.userId)
        println()
    }
    
    func test2() {
        var c:ContextClass = ContextClass(stateObject: ConcreteStateA())
        c.request()
        c.request()
        c.request()
        c.request()
        println()
    }
    
    func test3() {
        var chain: ChainState = ChainState()
        chain.pull()
        chain.pull()
        chain.pull()
        chain.pull()
        
        println()
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


protocol StateProtocol {
    func handle(context: ContextClass)
}

class ConcreteStateA: StateProtocol {
    func handle(context: ContextClass) {
        context.state = ConcreteStateB()
        println("state B")
    }
}

class ConcreteStateB: StateProtocol {
    func handle(context: ContextClass) {
        context.state = ConcreteStateA()
        println("state A")
    }
}


class ContextClass {
    var state: StateProtocol
    
    init(stateObject:StateProtocol) {
        state = stateObject
        println("init state \(state)")
    }
    
    func request() {
        state.handle(self)
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class StateState {
    func pull(wrapper: ChainState) {
        wrapper
    }
}

class ChainState {
    private var current: StateState
    
    init() {
        current = Off()
        println("turning off")
    }
    func state(s: StateState) {
        current = s
    }
    func pull() {
        current.pull(self)
    }
}

class Off: StateState {
    override func pull(wrapper: ChainState) {
        wrapper.state(Low())
        println("low speed")
    }
}

class Low: StateState {
    override func pull(wrapper: ChainState) {
        wrapper.state(Medium())
        println("medium speed")
    }
}

class Medium: StateState {
    override func pull(wrapper: ChainState) {
        wrapper.state(High())
        println("hight speed")
    }
}

class High: StateState {
    
}




























