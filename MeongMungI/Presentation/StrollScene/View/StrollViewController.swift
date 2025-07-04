//
//  StrollViewController.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/18/25.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - 산책 뷰 컨트롤러
public final class StrollViewController: UIViewController {
    
    // 산책 커스텀 뷰
    private let strollView = StrollView()
    
    // MARK: - loadView
    public override func loadView() {
        self.view = strollView
    }

    // MARK: - viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavi()
    }
    
    // MARK: - setupNavi
    private func setupNavi() {
        self.navigationItem.leftBarButtonItem = strollView.leftBarButtonItem
    }

}
