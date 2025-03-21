//
//  CommunityViewController.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/18/25.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

public final class CommunityViewController: UIViewController {
    
    // 커뮤니티 화면을 관리하는 코디네이터
    weak var coordinator: CommunityCoordinator?
    
    // viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemMint
    }
    
    

}
