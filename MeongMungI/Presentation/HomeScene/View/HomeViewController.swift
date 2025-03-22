//
//  HomeViewController.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/18/25.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

// MARK: - 홈 뷰컨트롤러
public final class HomeViewController: UIViewController {
    // 홈 커스텀 뷰
    private let homeView = HomeView()
    
    // 홈 화면을 관리하는 코디네이터
    weak var coordinator: HomeCoordinator?
    
    // loadView
    public override func loadView() {
        self.view = homeView
    }
    
    // viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBarButtonItem()
    }
    
    // 네비게이션 바 버튼 아이템 설정
    private func configureNavBarButtonItem() {
        self.navigationItem.leftBarButtonItem = homeView.leftBarButtonItem
        self.navigationItem.rightBarButtonItem = homeView.rightBarButtonItem
    }
    

}
