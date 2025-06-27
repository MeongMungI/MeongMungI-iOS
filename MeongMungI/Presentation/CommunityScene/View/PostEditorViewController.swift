//
//  PostCreationViewController.swift
//  MeongMungI
//
//  Created by 7aeHoon on 6/16/25.
//

import UIKit
import PhotosUI
import RxSwift
import RxCocoa

// MARK: - 사용자가 커뮤니티에 게시글을 작성하기 위한 뷰 컨트롤러
public final class PostEditorViewController: UIViewController {
    private let postEditorView = PostEditorView()
    private let disposeBag = DisposeBag()
    // 선택된 사진들의 상태를 가지는 BehaviorRelay
    private let photosRelay = BehaviorRelay<[Photo]>(value: [])
    // 포토 컬렉션뷰 단일 섹션
    private typealias Section = Int
    // 포토 컬렉센뷰 데이터 소스
    private var dataSource: UICollectionViewDiffableDataSource<Section, Photo>!
    
    
    // MARK: - loadView
    public override func loadView() {
        self.view = postEditorView
    }
    
    // MARK: - viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupDelegate()
        setupNavigationBar()
        setupDataSource()
        bindBoardSelectionButton()
        bindPhotoSelectionButton()
        bindphotosRelay()
        postEditorView.titleTextField.inputAccessoryView = createDoneToolbar()
        postEditorView.contentTextView.inputAccessoryView = createDoneToolbar()
    }
    
    // MARK: - 델리게이트 설정
    private func setupDelegate() {
        self.postEditorView.contentTextView.delegate = self
        self.postEditorView.photoCollectionView.delegate = nil
    }
    
    // MARK: - 네비게이션 바 설정
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = postEditorView.rightBarButtonItem
    }
    
    // MARK: - setupDataSource
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Photo>(collectionView: postEditorView.photoCollectionView) {
            collectionView, indexPath, photo in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.ID,
                                                          for: indexPath) as? PhotoCollectionViewCell
            cell?.configure(with: photo)
            cell?.onRemove = { [weak self] in
                guard let self = self else { return }
                var value = self.photosRelay.value
                value.removeAll { $0.id == photo.id }
                self.photosRelay.accept(value)
            }
            return cell
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Photo>()
        snapshot.appendSections([0])
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    // MARK: - 게시판 선택 버튼 클릭 이벤트
    private func bindBoardSelectionButton() {
        postEditorView.boardSelectionButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.presentToBoardSelection()
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - 사진 선택 버튼 클릭 이벤트
    private func bindPhotoSelectionButton() {
        postEditorView.photoSelectionButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.presentPhotoPicker()
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - 사진첩에서 가져온 사진들 바인드
    private func bindphotosRelay() {
        photosRelay
            .asDriver()
            .drive(onNext: { [weak self] photos in
                guard let self = self else { return }
                var snap = self.dataSource.snapshot()
                snap.deleteAllItems()
                snap.appendSections([0])
                snap.appendItems(photos, toSection: 0)
                self.dataSource.apply(snap, animatingDifferences: true)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - 확인 버튼 툴바 생성
    private func createDoneToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil,
                                        action: nil)
        let doneButton = UIBarButtonItem(title: "확인",
                                         style: .done,
                                         target: self,
                                         action: #selector(DismissKeyboard))
        toolbar.setItems([flexSpace, doneButton], animated: true)
        toolbar.sizeToFit()
        return toolbar
    }
    
    @objc
    private func DismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - 화면 전환 익스텐션
extension PostEditorViewController {
    // MARK: - 게시판 선택 화면으로 이동
    private func presentToBoardSelection() {
        let boardSelectionViewController = BoardSelectionViewController()
        boardSelectionViewController.modalPresentationStyle = .pageSheet
        
        if let sheet = boardSelectionViewController.sheetPresentationController {
            let customDetent = UISheetPresentationController.Detent.custom(identifier: .init("customDetent")) { context in
                context.maximumDetentValue * 0.6
            }
            
            sheet.detents = [customDetent]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.preferredCornerRadius = 20
            // 손잡이 숨기기
            sheet.prefersGrabberVisible = false
        }
        
        // 클로저로부터 전달된 게시판 타입을 텍스트 필드에 할당
        boardSelectionViewController.didSelectBoard = { [weak self] selectedBoard in
            guard let self = self else { return }
            self.postEditorView.boardSelectionButton.configurationUpdateHandler = { bt in
                var configure = bt.configuration
                var attributedStr = AttributedString(selectedBoard + " 게시판")
                attributedStr.font = UIFont.pretendard(size: 16, family: .semiBold)
                configure?.attributedTitle = attributedStr
                bt.configuration = configure
            }
        }
        
        present(boardSelectionViewController, animated: true)
    }
    
    // MARK: - 업로드할 사진 선택 화면으로 이동
    private func presentPhotoPicker() {
        var config = PHPickerConfiguration()
        // 최대로 선택 가능한 수
        config.selectionLimit = 4
        // 이미지만 선택 가능
        config.filter = .images
        // picker 생성
        let picker = PHPickerViewController(configuration: config)
        // 델리게이트 설정
        picker.delegate = self
        present(picker, animated: true)
    }
}

// MARK: - TextView 델리게이트 익스텐션
extension PostEditorViewController: UITextViewDelegate {
    // MARK: - textViewDidBeginEditing
    public func textViewDidBeginEditing(_ textView: UITextView) {
        // 텍스트뷰의 텍스트 컬러가 placeholderText일 경우. 즉 텍스트가 없는 상태
        if textView.textColor == .placeholderText {
            textView.text = nil
            textView.textColor = .secondaryTextColor
        }
    }
    
    // MARK: - textViewDidEndEditing
    public func textViewDidEndEditing(_ textView: UITextView) {
        // 사용자가 입력을 하지 않았을 때
        if textView.text.isEmpty {
            // placeholder 설정
            textView.text = "내용을 입력하세요"
            textView.textColor = .placeholderText
        }
    }
}

// MARK: - PHPickerView 델리게이트 익스텐션
extension PostEditorViewController: PHPickerViewControllerDelegate {
    public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        // 선택된 사진들을 하나씩 가져오기
        for result in results {
            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] imageObj, _ in
                    guard let self = self, let image = imageObj as? UIImage else { return }
                    DispatchQueue.main.async {
                        var value = self.photosRelay.value
                        value.append(Photo(image: image))
                        self.photosRelay.accept(value)
                    }
                }
            }
        }
    }
}
