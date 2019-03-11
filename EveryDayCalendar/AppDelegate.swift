//
//  AppDelegate.swift
//  EveryDayCalendar
//
//  Created by Glen Brixey on 3/8/19.
//  Copyright © 2019 Glen Brixey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var calendarViewController: CalendarViewController?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppearanceManager.setupAppearance()
        let calendarViewController = CalendarViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: calendarViewController)
        window?.makeKeyAndVisible()
        self.calendarViewController = calendarViewController
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        calendarViewController?.refreshView()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}

