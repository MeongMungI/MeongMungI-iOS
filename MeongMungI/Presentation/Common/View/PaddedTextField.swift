//
//  PaddedTextField.swift
//  MeongMungI
//
//  Created by 7aeHoon on 5/1/25.
//

import UIKit

// MARK: - UITextField를 상속받은 커스텀 텍스트 필드로, 텍스트 필드의 양끝에 패딩을 설정
final class PaddedTextField: UITextField {
    // 필드 경계와 텍스트 시작 여유
    private let horizontalPadding: CGFloat = 20
    // 텍스트와 clear 버튼 간 여유
    private let clearSpacing: CGFloat = 10

    // MARK: - 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func commonInit() {
        clearButtonMode = .whileEditing
    }

    // MARK: - 텍스트/편집 영역
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return adjustedRect(forBounds: bounds)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return adjustedRect(forBounds: bounds)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return adjustedRect(forBounds: bounds)
    }

    private func adjustedRect(forBounds bounds: CGRect) -> CGRect {
        let clearWidth = (clearButtonMode != .never) ? clearButtonRect(forBounds: bounds).width : 0
        let x = horizontalPadding
        let y: CGFloat = 0
        let width = bounds.width - horizontalPadding - clearWidth - clearSpacing - horizontalPadding
        let height = bounds.height
        return CGRect(x: x, y: y, width: width, height: height)
    }

    // MARK: - clear 버튼 위치
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let buttonSize = super.clearButtonRect(forBounds: bounds)
        let x = bounds.width - horizontalPadding - buttonSize.width
        let y = (bounds.height - buttonSize.height) / 2
        return CGRect(x: x, y: y, width: buttonSize.width, height: buttonSize.height)
    }
}
