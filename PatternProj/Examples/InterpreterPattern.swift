//
//  InterpreterPattern.swift
//  PatternProj
//
//  Created by lukasz on 05/07/15.
//  Copyright (c) 2015 lukasz. All rights reserved.
//

import Foundation
import Swift

/*
The interpreter pattern is used to evaluate sentences in a language.

In computer programming, the interpreter pattern is a design pattern that specifies how to evaluate sentences in a language. The basic idea is to have a class for each symbol (terminal or nonterminal) in a specialized computer language. The syntax tree of a sentence in the language is an instance of the composite pattern and is used to evaluate (interpret) the sentence for a client.[1]:243 See also Composite pattern.

*/

protocol IntegerExp {
    func evaluate(context: IntegerContext) -> Int
    func replace(character: Character, integerExp: IntegerExp) -> IntegerExp
    func copy() -> IntegerExp
}

class IntegerContext {
    private var data: [Character:Int] = [:]
    
    func lookup(name: Character) -> Int {
        return self.data[name]!
    }
    
    func assign(integerVarExp: IntegerVarExp, value: Int) {
        self.data[integerVarExp.name] = value
    }
}

class IntegerVarExp: IntegerExp {
    let name: Character
    
    init(name: Character) {
        self.name = name
    }
    
    func evaluate(context: IntegerContext) -> Int {
        return context.lookup(self.name)
    }
    
    func replace(character: Character, integerExp: IntegerExp) -> IntegerExp {
        if name == self.name {
            return integerExp.copy()
        } else {
            return IntegerVarExp(name: self.name)
        }
    }
    
    func copy() -> IntegerExp {
        return IntegerVarExp(name: self.name)
    }
}

class AddExp: IntegerExp {
    private var operand1: IntegerExp
    private var operand2: IntegerExp
    
    init(op1: IntegerExp, op2: IntegerExp) {
        self.operand1 = op1
        self.operand2 = op2
    }
    
    func evaluate(context: IntegerContext) -> Int {
        return self.operand1.evaluate(context) + self.operand2.evaluate(context)
    }
    
    func replace(character: Character, integerExp: IntegerExp) -> IntegerExp {
        return AddExp(op1: operand1.replace(character, integerExp: integerExp), op2: operand2.replace(character, integerExp: integerExp))
    }
    
    func copy() -> IntegerExp {
        return AddExp(op1: self.operand1, op2: self.operand2)
    }
}

/*
usage
*/

class TestInterpreter {
    func test() {
        var expression: IntegerExp?
        var intContext = IntegerContext()
        
        var a = IntegerVarExp(name: "A")
        var b = IntegerVarExp(name: "B")
        var c = IntegerVarExp(name: "C")
        
        expression = AddExp(op1: a, op2: AddExp(op1: b, op2: c))
        
        intContext.assign(a, value: 2)
        intContext.assign(b, value: 1)
        intContext.assign(c, value: 3)
        
        var result = expression?.evaluate(intContext)
        println("\(result)")
        println()
    }
    
    func test2() {
        var interpreter: RNIntObject = RNIntObject()

        interpreter.interpreter("MCMXCVI")
        interpreter.interpreter("MMMCMXCIX")
        interpreter.interpreter("MDCLXVI")
        interpreter.interpreter("DCCCLXXXVIII")
        
        interpreter.interpreter("MDCLXVIIII")
        interpreter.interpreter("CXCX")
        println()        
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

protocol Interpreter {
    func one() -> String
    func four() -> String
    func five() -> String
    func nine() -> String
    func multiplier() -> Int
}

class RNIntObject {
    private var thousands: RNInterpreter
    private var hundreds: RNInterpreter
    private var tens: RNInterpreter
    private var ones: RNInterpreter
    
    init() {
        thousands = Thousand()
        hundreds = Hundred()
        tens = Ten()
        ones = One()
    }
    
    func interpreter(input1:String) -> Int {
        var total: Int = 0
        var input = input1
        
        thousands.interpreter(&input, total: &total)
        hundreds.interpreter(&input, total: &total)
        tens.interpreter(&input, total: &total)
        ones.interpreter(&input, total: &total)
        
        if input1 == "" || input != "" {
            println("error \(input)")
            return 0
        }
        
        println("total \(total)")
        return total
    }
}

class RNInterpreter: Interpreter {
    
    private func interpreter(inout input: String, inout total: Int) {
        var index: Int = 0
        
        let vFour = four()
        let vNine = nine()
        
        if input.hasPrefix(vNine) {
            total += 9 * multiplier()
            index += count(vNine)
        } else if input.hasPrefix(vFour) {
            total += 4 * multiplier()
            index += count(vFour)
        } else {
            var vFive = five()
            if input.hasPrefix(vFive) {
                total += 5 * multiplier()
                index = count(vFive)
            } else {
                index = 0
            }
            input = input.substringFromIndex(advance(input.startIndex, index))
            
            for i in 0...2 {
                var vOne = one()
                if input.hasPrefix(vOne) {
                    total += multiplier()
                    index = count(vOne)
                } else {
                    index = 0
                    break
                }
                input = input.substringFromIndex(advance(input.startIndex, index))
                index = 0
            }
        }
        
        if count(input) > 0 {
            input = input.substringFromIndex(advance(input.startIndex, index))
        }
    }
    
    func one() -> String {
        return ""
    }
    func four() -> String {
        return ""
    }
    func five() -> String {
        return ""
    }
    func nine() -> String {
        return ""
    }
    func multiplier() -> Int {
        return 0
    }
}

class Thousand: RNInterpreter {
    
    override func one() -> String {
        return "M"
    }
    override func four() -> String {
        return ""
    }
    override func five() -> String {
        return "\0"
    }
    override func nine() -> String {
        return ""
    }
    override func multiplier() -> Int {
        return 1000
    }
}

class Hundred: RNInterpreter {
    
    override func one() -> String {
        return "C"
    }
    override func four() -> String {
        return "CD"
    }
    override func five() -> String {
        return "D"
    }
    override func nine() -> String {
        return "CM"
    }
    override func multiplier() -> Int {
        return 100
    }
}

class Ten: RNInterpreter {
    
    override func one() -> String {
        return "X"
    }
    override func four() -> String {
        return "XL"
    }
    override func five() -> String {
        return "L"
    }
    override func nine() -> String {
        return "XC"
    }
    override func multiplier() -> Int {
        return 10
    }
}

class One: RNInterpreter {
    
    override func one() -> String {
        return "I"
    }
    override func four() -> String {
        return "IV"
    }
    override func five() -> String {
        return "V"
    }
    override func nine() -> String {
        return "IX"
    }
    
    override func multiplier() -> Int {
        return 1
    }
}














