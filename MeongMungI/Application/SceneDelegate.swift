//
//  SceneDelegate.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/17/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        self.window = window

        let loginViewController = LoginViewController()
        let loginNavigationController = UINavigationController(rootViewController: loginViewController)
        loginNavigationController.configureBarAppearnace()
        
        // 라이트 모드만 허용
        window.overrideUserInterfaceStyle = .light
        // 루트 뷰 교체
        window.rootViewController = loginNavigationController
        window.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
}

extension SceneDelegate {
    // 탭 바로 화면 전환
    func transitionToMainTabBarController() {
        guard let window = window else { return }
        let mainTabBarController = MainTabBarController()
        // 루트 뷰 컨트롤러를 메인 탭 바 컨트롤러로 교체
        window.rootViewController = mainTabBarController
        // 루트 뷰 컨트롤러 전환 시 애니메이션 적용
        UIView.transition(with: window, duration: 0.2, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
