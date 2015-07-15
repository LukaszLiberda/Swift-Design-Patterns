//
//  SingletonPattern.swift
//  PatternProj
//
//  Created by lukaszliberda on 07.07.2015.
//  Copyright (c) 2015 lukasz. All rights reserved.
//

import Foundation

/*
+ (MyClass *)singleton
    {
        static MyClass *sharedMyClass = nil;
        static dispatch_once_t once = 0;
        dispatch_once(&once, ^{sharedMyClass = [[self alloc] init];});
        return sharedMyClass;
}
*/