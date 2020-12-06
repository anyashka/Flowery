//
//  AppDelegate.swift
//  Flowery
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    /// App Dependencies Provider.
    let dependencyProvider: DependencyProvider = DefaultDependencyProvider()

    /// App flow coordinator.
    private var appFlowCoordinator: FlowCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        appFlowCoordinator = AppFlowCoordinator(dependencyProvider: dependencyProvider)
        window?.rootViewController = appFlowCoordinator?.rootViewController
        window?.makeKeyAndVisible()
        appFlowCoordinator?.start(animated: false)
        return true
    }
}
