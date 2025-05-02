//
//  ProfileSetupViewController.swift
//  MeongMungI
//
//  Created by 7aeHoon on 4/30/25.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

// MARK: - 초기 프로필 설정 뷰 컨트롤러
public final class ProfileSetupViewController: UIViewController {
    
    // custom view
    private let profileSetupView = ProfileSetupView()
    
    // 로그인 화면을 관리하는 코디네이터
    weak var coordinator: AppCoordinator?
    
    private let disposeBag = DisposeBag()
    
    // loadView
    public override func loadView() {
        self.view = profileSetupView
    }
    
    // viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    
}
