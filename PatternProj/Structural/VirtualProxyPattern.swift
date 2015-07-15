//
//  VirtualProxyPattern.swift
//  PatternProj
//
//  Created by lukaszliberda on 06.07.2015.
//  Copyright (c) 2015 lukasz. All rights reserved.
//

import Foundation

/*

The proxy pattern is used to provide a surrogate or placeholder object, which references an underlying object. Virtual proxy is used for loading object on demand.



*/

protocol HEVSuitMedicalAid {
    func administerMorphine() -> String
}

class HEVSuit: HEVSuitMedicalAid {
    func administerMorphine() -> String {
        return "Morphine aministered"
    }
}

class HEVSuitHumanInterface: HEVSuitMedicalAid {
    lazy private var physicalSuit: HEVSuit = HEVSuit()
    
    func administerMorphine() -> String {
        return physicalSuit.administerMorphine()
    }
}

/*
usage
*/

class TestVirtualProxy {
    func test() {
        let humanInterface = HEVSuitHumanInterface()
        humanInterface.administerMorphine()
        println()
    }
}