//
//  BuilderPattern.swift
//  PatternProj
//
//  Created by lukaszliberda on 06.07.2015.
//  Copyright (c) 2015 lukasz. All rights reserved.
//

import Foundation

/*
The builder pattern is used to create complex objects with constituent parts that must be created in the same order or using a specific algorithm. An external class controls the construction algorithm.

The builder pattern is an object creation software design pattern. Unlike the abstract factory pattern and the factory method pattern whose intention is to enable polymorphism, the intention of the builder pattern is to find a solution to the telescoping constructor anti-pattern[citation needed]. The telescoping constructor anti-pattern occurs when the increase of object constructor parameter combination leads to an exponential list of constructors. Instead of using numerous constructors, the builder pattern uses another object, a builder, that receives each initialization parameter step by step and then returns the resulting constructed object at once.

The builder pattern has another benefit. It can be used for objects that contain flat data (html code, SQL query, X.509 certificate...), that is to say, data that can't be easily edited. This type of data cannot be edited step by step and must be edited at once. The best way to construct such an object is to use a builder class.

Builder often builds a Composite. Often, designs start out using Factory Method (less complicated, more customizable, subclasses proliferate) and evolve toward Abstract Factory, Prototype, or Builder (more flexible, more complex) as the designer discovers where more flexibility is needed. Sometimes creational patterns are complementary: Builder can use one of the other patterns to implement which components are built. Builders are good candidates for a fluent interface.

*/

class DeathStarBuilder {
    var x: Double?
    var y: Double?
    var z: Double?
    
    typealias BuilderClosure = (DeathStarBuilder) -> ()
    
    init(builderClosure: BuilderClosure) {
        builderClosure(self)
    }
}

struct DeathStar {
    let x: Double
    let y: Double
    let z: Double
    
    init?(builder: DeathStarBuilder) {
        if let x = builder.x, y = builder.y, z = builder.z {
            self.x = x
            self.y = y
            self.z = z
        } else {
            return nil
        }
    }
}

/*
usage
*/

class TestBuilder {
    func test() {
        let empire = DeathStarBuilder { builder in
            builder.x = 0.1
            builder.y = 0.2
            builder.z = 0.3
        }
        
        let deathStar = DeathStar(builder: empire)
        println("death star : \(deathStar)")
        println()
    }
    
    func test2() {
        var hawaiian_pizzabuilser = HawaiianPizzaBuilder()
        var spicy_pizzabuilder = SpicyPizzaBuilder()

        var waiter: Waiter = Waiter(pizzaBC: hawaiian_pizzabuilser)
        waiter.constructPizza()
        waiter.pizza().descriptionPizza()
        
        waiter.pizzaBuilder(spicy_pizzabuilder)
        waiter.constructPizza()
        waiter.pizza().descriptionPizza()
        println()
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class Pizza {
    var dought: String = ""
    var sauce: String = ""
    var topping: String = ""
    
    func descriptionPizza() {
        println("dought: \(dought)\n sauce: \(sauce)\n topping: \(topping)\n")
    }
}

protocol PizzaBuilder {

    func buildDough()
    func buildSauce()
    func buildTopping()
}

class PizzaBuilderC: PizzaBuilder {
    var pizza: Pizza
    
    init() {
        pizza = Pizza()
    }
    
    func buildDough() {
        
    }
    
    func buildSauce() {
        
    }
    
    func buildTopping() {
        
    }
}



class HawaiianPizzaBuilder: PizzaBuilderC {
    override func buildDough() {
        pizza.dought = "cross"
    }
    
    override func buildSauce() {
        pizza.sauce = "mild"
    }
    
    override func buildTopping() {
        pizza.topping = "ham+pinapple"
    }
}

class SpicyPizzaBuilder: PizzaBuilderC {
    override func buildDough() {
        pizza.dought = "pan baked"
    }
    
    override func buildSauce() {
        pizza.sauce = "hot"
    }
    
    override func buildTopping() {
        pizza.topping = "pepperoni+salami"
    }
}

class Waiter {
    private var pizzaBuilder: PizzaBuilderC
    
    init(pizzaBC: PizzaBuilderC) {
        pizzaBuilder = pizzaBC
    }
    
    func pizza() -> Pizza {
        return pizzaBuilder.pizza
    }
    
    func pizzaBuilder(pizzaBC: PizzaBuilderC) {
        pizzaBuilder = pizzaBC
    }
    
    func constructPizza() {
        pizzaBuilder.buildDough()
        pizzaBuilder.buildSauce()
        pizzaBuilder.buildTopping()
    }
}






























