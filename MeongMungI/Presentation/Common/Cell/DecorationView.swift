//
//  DecorationView.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/22/25.
//

import UIKit

// MARK: - 컬렉션 뷰 내부 섹션의 배경을 위한 데코레이션 뷰
public final class DecorationView: UICollectionReusableView {
    
    // reusable ID
    static let ID = "DecorationView"
    
    private let lineView = UIView().then {
        $0.backgroundColor = .backgroundColor
        $0.clipsToBounds = true
    }
    
    // init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // UI 설정
    private func setupUI() {
        self.addSubview(lineView)
        
        lineView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
}
