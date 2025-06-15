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
    
    
    // MARK: - loadView
    public override func loadView() {
        self.view = myPageView
    }
    
    // MARK: - viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavi()
    }
    
    // MARK: - setupNavi
    private func setupNavi() {
        self.navigationItem.leftBarButtonItem = myPageView.leftBarButtonItem
    }
    
    
}
