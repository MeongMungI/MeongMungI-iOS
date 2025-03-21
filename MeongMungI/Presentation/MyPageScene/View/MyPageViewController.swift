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

// MARK: - 마이 페이지 뷰 컨트롤러
public final class MyPageViewController: UIViewController {
    
    // 마이 페이지 화면을 관리하는 코디네이터
    weak var coordinator: MyPageCoordinator?
    
    // viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemCyan
    }
    
    

}
