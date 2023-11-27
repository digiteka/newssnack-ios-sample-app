//
//  AppDelegate.swift
//  NewsSnackSample
//
//  Created by Cédric Derache on 20/09/2023.
//

import UIKit
import NewsSnackSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        do {
            try NewsSnack.shared.initialize(config: DTKNSConfig(mdtk: "01472001"))
        } catch {
            print("Can't init NewsSnack with error \(error.localizedDescription)")
        }
        NewsSnack.shared.setLoggerDelegate(self)
        NewsSnack.shared.setTrackingDelegate(self)

        return true
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

// MARK: DTKNSLoggerDelegate
extension AppDelegate: DTKNSLoggerDelegate {
    func debug(message: String) {
        print("debug " + message)
    }

    func info(message: String) {
        print("info " + message)
    }

    func warn(message: String) {
        print("warn " + message)
    }

    func error(message: String, error: Error?) {
        print("error " + message, error as Any)
    }
}

// MARK: DTKNSLoggerDelegate
extension AppDelegate: DTKNSTrackingDelegate {
    func trackEvent(_ event: TrackingEvent, sessionId: String?) {
        print("Tracking event received \(event) for sessionId \(sessionId ?? "nil")")
    }
}
