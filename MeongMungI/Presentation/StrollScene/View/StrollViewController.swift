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

// MARK: - 산책 뷰 컨트롤러
public final class StrollViewController: UIViewController {
    
    // 산책 화면을 관리하는 코디네이터
    weak var coordinator: StrollCoordinator?

    // viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemRed
    }
    
    

}
