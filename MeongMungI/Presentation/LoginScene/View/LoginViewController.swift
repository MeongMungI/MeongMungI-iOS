//
//  LoginViewController.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/17/25.
//

import UIKit

public final class LoginViewController: UIViewController {
    
    // 커스텀 로그인 뷰
    private let loginView = LoginView()
    
    // loadView
    public override func loadView() {
        self.view = loginView
    }
    
    // viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    

}
