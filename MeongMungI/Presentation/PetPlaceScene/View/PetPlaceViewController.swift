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
    
    
    // MARK: - loadView
    public override func loadView() {
        self.view = petPlaceView
    }
    
    // MARK: - viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavi()
    }
    
    // MARK: - setupNavi
    private func setupNavi() {
        self.navigationItem.leftBarButtonItem = petPlaceView.leftBarButtonItem
    }

}
