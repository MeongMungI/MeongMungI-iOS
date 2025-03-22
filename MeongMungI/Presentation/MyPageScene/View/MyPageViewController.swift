//
//  MyPageViewController.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/18/25.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

// MARK: - 마이페이지 뷰컨트롤러
public final class MyPageViewController: UIViewController {
    
    // 마이 페이지 커스텀 뷰
    private let myPageView = MyPageView()
    
    // 마이 페이지 화면을 관리하는 코디네이터
    weak var coordinator: MyPageCoordinator?
    
    // loadView
    public override func loadView() {
        self.view = myPageView
    }
    
    // viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네비게이션 왼쪽 바 버튼 아이템 설정
        configureLeftNavigationBarItem(with: myPageView.leftBarButtonItem)
    }
    
    
}
