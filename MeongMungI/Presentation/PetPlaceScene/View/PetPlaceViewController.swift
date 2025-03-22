//
//  PetPlaceViewController.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/18/25.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

// MARK: - 반려견 동반 장소 뷰컨트롤러
public final class PetPlaceViewController: UIViewController {
    
    // 반려견 동반 장소 커스텀 뷰
    private let petPlaceView = PetPlaceView()
    
    // 반려견 동반 장소 화면을 관리하는 코디네이터
    weak var coordinator: PetPlaceCoordinator?
    
    // loadView
    public override func loadView() {
        self.view = petPlaceView
    }
    
    // viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        // 네비게이션 왼쪽 바 버튼 아이템 설정
        configureLeftNavigationBarItem(with: petPlaceView.leftBarButtonItem)
        
    }

}
