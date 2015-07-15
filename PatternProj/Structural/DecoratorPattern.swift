//
//  DecoratorPattern.swift
//  PatternProj
//
//  Created by lukaszliberda on 06.07.2015.
//  Copyright (c) 2015 lukasz. All rights reserved.
//

import Foundation

/*
The decorator pattern is used to extend or alter the functionality of objects at run- time by wrapping them in an object of a decorator class. This provides a flexible alternative to using inheritance to modify behaviour.


In object-oriented programming, the decorator pattern (also known as Wrapper, an alternative naming shared with the Adapter pattern) is a design pattern that allows behavior to be added to an individual object, either statically or dynamically, without affecting the behavior of other objects from the same class.[1] The decorator pattern is often useful for adhering to the Single Responsibility Principle, as it allows functionality to be divided between classes with unique areas of concern.[2]


*/


protocol Coffee {
    func getCost() -> Double
    func getIngredients() -> String
}

class SimpleCoffee: Coffee {
    func getCost() -> Double {
        return 1.0
    }
    
    func getIngredients() -> String {
        return "Coffee"
    }
}

class CoffeeDecorator: Coffee {
    private let decoratedCoffee: Coffee
    private let ingredientSeparator: String = ", "
    
    required init(decoratedCoffee: Coffee) {
        self.decoratedCoffee = decoratedCoffee
    }
    
    func getCost() -> Double {
        return decoratedCoffee.getCost()
    }
    
    func getIngredients() -> String {
        return decoratedCoffee.getIngredients()
    }
}

class Milk: CoffeeDecorator {
    required init(decoratedCoffee: Coffee) {
        super.init(decoratedCoffee: decoratedCoffee)
    }
    
    override func getCost() -> Double {
        return super.getCost() + 0.5
    }
    
    override func getIngredients() -> String {
        return super.getIngredients() + ingredientSeparator + "Milk"
    }
}

class WhipCoffee: CoffeeDecorator {
    required init(decoratedCoffee: Coffee) {
        super.init(decoratedCoffee: decoratedCoffee)
    }
    
    override func getCost() -> Double {
        return super.getCost() + 0.7
    }
    
    override func getIngredients() -> String {
        return super.getIngredients() + ingredientSeparator + "Whip"
    }
}

/*
usage
*/

class TestDecorator {
    func test() {
        var someCoffee: Coffee = SimpleCoffee()
        println("Cost: \(someCoffee.getCost()); Ingredients: \(someCoffee.getIngredients())")
        someCoffee = Milk(decoratedCoffee: someCoffee)
        println("Cost: \(someCoffee.getCost()); Ingredients: \(someCoffee.getIngredients())")
        someCoffee = WhipCoffee(decoratedCoffee: someCoffee)
        println("Cost: \(someCoffee.getCost()); Ingredients: \(someCoffee.getIngredients())")
        println()
    }
    
    func test2() {
        var aWidget = BorderDecorator(w: BorderDecorator(w: ScrollDecorator(w: TextWidget(w: 80, h: 24))))
        aWidget.draw()
        println()
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

protocol Widget {
    func draw()
}

class TextWidget: Widget {
    private var width, height: Int
    
    init(w: Int, h: Int) {
        width = w
        height = h
    }
    
    func draw() {
        println("TextWidget: \(width), \(height)")
    }
}

class DecoratorWidget: Widget {
    private var wid: Widget
    
    init(w: Widget) {
        wid = w
    }
    
    func draw() {
        wid.draw()
    }
}


class BorderDecorator: DecoratorWidget  {
    override init(w: Widget) {
        super.init(w: w)
    }
    
    override func draw() {
        super.draw()
        println("Border decorator")
    }
}

class ScrollDecorator: DecoratorWidget {
    override init(w: Widget) {
        super.init(w: w)
    }
    
    override func draw() {
        super.draw()
        println("Scroll decorator")
    }
}































