import UIKit
import CoreData
import OSLog

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties
    
    var window: UIWindow?

    private let quickActionsManager = QuickActionsManager()
    private let detector = Detector()
    
    /// allow the orientation to be changed as per the settings for each individual view controller
    var restrictRotation:UIInterfaceOrientationMask = .all
    
    private var log = OSLog(subsystem: ConstantsLog.subSystem, category: ConstantsLog.categoryAppDelegate)
    
    // MARK: - Application Life Cycle
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        detector.start()
        
        trace("in didFinishLaunchingWithOptions", log: log, category: ConstantsLog.categoryAppDelegate, type: .info)
        
        var controller: UIViewController!
        
        if UserDefaults.standard.isUserAgreementConfirmed {
            controller = createTabBarController()
        } else {
            controller = creatWelcomeViewController()
        }
        
        window = UIWindow()
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
        
        return true
        
    }

    /// used to allow/prevent the specific views from changing orientation when rotating the device
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask
    {
        return self.restrictRotation
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }
  
    // Handle Quick Actions
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        if let quickActionType = QuickActionType(rawValue: shortcutItem.type) {
            quickActionsManager.handleQuickAction(quickActionType)
        }
        
        completionHandler(true)
    }
}

// MARK: - Private

private extension AppDelegate {
    
    func createTabBarController() -> UIViewController {
        return UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
    }
    
    func creatWelcomeViewController() -> UIViewController {
        let welcomeViewController = UIStoryboard(name: "WelcomeViewController", bundle: .main).instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
        let navigationController = UINavigationController(rootViewController: welcomeViewController)
        
        welcomeViewController.nextAction = { [weak self] in
            guard let oneLastThingViewController = self?.createOneLastThingViewController() else { return }
            navigationController.pushViewController(oneLastThingViewController, animated: true)
        }
        
        return navigationController
    }
    
    func createOneLastThingViewController() -> OneLastThingViewController {
        let oneLastThingViewController = UIStoryboard(name: "OneLastThingViewController", bundle: .main).instantiateViewController(withIdentifier: "OneLastThingViewController") as! OneLastThingViewController
        
        oneLastThingViewController.nextAction = { [weak self] in
            self?.startApplication()
        }
        
        return oneLastThingViewController
    }
    
    func startApplication() {
        guard let window = window else { return }
        window.rootViewController = createTabBarController()
        window.makeKeyAndVisible()
        
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
