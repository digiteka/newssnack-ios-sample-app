//
//  AppDelegate.swift
//  NewsSnackSample
//
//  Created by Cédric Derache on 20/09/2023.
//

import UIKit
import VideoFeedSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        do {
            try NewsSnack.shared.initialize(config: DTKNSConfig(mdtk: "01472001"))
        } catch {
            print("Can't init NewsSnack with error \(error.localizedDescription)")
        }
        VideoFeed.shared.setLoggerDelegate(self)
        VideoFeed.shared.setTrackingDelegate(self)

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


class CustomInjector: NSObject, DTKNSInjector {
    func hasViewAvailableFor(placementId: String) -> Bool {
        true
    }

    func buildViewFor(placementId: String) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 250))
        view.backgroundColor = .red
        return view
    }

    func onViewVisibilityChanged(view: UIView, isVisible: Bool) {
        print("onViewVisibilityChanged \(isVisible)")
    }

    func setTagParams(zoneName: String, adID: String) -> [String : String] {
        print("nothing to do here")
        return [:]
    }


}

extension AppDelegate:DTKNSLinkDelegate {
    func shouldOpenLink(_ url: URL) {
        print("DO something with \(url)")
    }
    

}

// MARK: DTKNSLoggerDelegate
extension AppDelegate: DTKNSLoggerDelegate {
    func VideoFeedDebug(message: String) {
        print("debug " + message)

    }
    
    func VideoFeedInfo(message: String) {
        print("info " + message)

    }
    
    func VideoFeedWarn(message: String) {
        print("warn " + message)
    }
    
    func VideoFeedError(message: String, error: Error?) {
        print("error " + message, error as Any)
    }

}

// MARK: DTKNSLoggerDelegate
extension AppDelegate: DTKNSTrackingDelegate {
    func trackEvent(_ event: TrackingEvent, sessionId: String?) {
        //print("Tracking event received \(event) for sessionId \(sessionId ?? "nil")")
    }
}
