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

// MARK: - 반려견 동반 장소 뷰 컨트롤러
public final class PetPlaceViewController: UIViewController {
    
    // 반려견 동반 장소 화면을 관리하는 코디네이터
    weak var coordinator: PetPlaceCoordinator?
    
    // viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBlue
    }
    
    

}
