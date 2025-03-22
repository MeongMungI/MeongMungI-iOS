//
//  StrollViewController.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/18/25.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

// MARK: - 산책 뷰컨트롤러
public final class StrollViewController: UIViewController {
    
    // 산책 커스텀 뷰
    private let strollView = StrollView()
    
    // 산책 화면을 관리하는 코디네이터
    weak var coordinator: StrollCoordinator?
    
    // loadView
    public override func loadView() {
        self.view = strollView
    }

    // viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        // 네비게이션 왼쪽 바 버튼 아이템 설정
        configureLeftNavigationBarItem(with: strollView.leftBarButtonItem)
    }

}
