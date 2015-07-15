//
//  AppDelegate.swift
//  PatternProj
//
//  Created by lukasz on 05/07/15.
//  Copyright (c) 2015 lukasz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // MARK: Creation Pattern
        var testFactory = TestAbstractFactory()
        testFactory.test()
        testFactory.test2()
        
        var testBuilder = TestBuilder()
        testBuilder.test()
        testBuilder.test2()
        
        var testFactoryMethod = TestFactoryMethods()
        testFactoryMethod.test()
        testFactoryMethod.test2()
        
        var testPrototype = TestPrototype()
        testPrototype.test()
        testPrototype.test2()
        
        // MARK: Structural Pattern
        
        var testAdapter = TestAdapter()
        testAdapter.test()
        testAdapter.test2()
        
        var testBridgePattern = TestBridge()
        testBridgePattern.test()
        testBridgePattern.test2()
        
        var testCompositePattern = TestComposite()
        testCompositePattern.test()
        testCompositePattern.test2()
        
        var testDecorator = TestDecorator()
        testDecorator.test()
        testDecorator.test2()
        
        var testFacade = TestFacade()
        testFacade.test()
        testFacade.test2()
        
        var testProxy = TestProxy()
        testProxy.test()
        testProxy.test2()
        testProxy.test3()
        
        // MARK: Behavioral Pattern
        
        var testChaninOfResponsibility = TestChainOfResponsibility()
        testChaninOfResponsibility.test()
        testChaninOfResponsibility.test2()
        testChaninOfResponsibility.test3()

        var testCommand = TestCommand()
        testCommand.test()
        testCommand.test2()
        
        var testInterp = TestInterpreter()
        testInterp.test()
        testInterp.test2()
        
        var testIterator = TestIterator()
        testIterator.test()
        testIterator.test2()
        
        var testMediator = TestMediator()
        testMediator.test()
        
        var testMemento = TestMemento()
        testMemento.test()
        testMemento.test2()
        
        var testObserver:TestObserver = TestObserver()
        testObserver.test()
        testObserver.test2()
        
        var testState: TestState = TestState()
        testState.test()
        testState.test2()
        testState.test3()
        
        var testStrategy: TestStrategy = TestStrategy()
        testStrategy.test()
        testStrategy.test2()
        
        var testVisitor: TestVisitor = TestVisitor()
        testVisitor.test()
        testVisitor.test2()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

