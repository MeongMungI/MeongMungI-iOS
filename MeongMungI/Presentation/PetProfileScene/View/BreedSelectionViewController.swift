//
//  BreedSelectionViewController.swift
//  MeongMungI
//
//  Created by 7aeHoon on 6/7/25.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - 사용자가 반려동물의 견종을 선택하기 위한 뷰 컨트롤러
public final class BreedSelectionViewController: UIViewController {
    
    private let breedSelectionView = BreedSelectionView()
    // 이전화면에 선택된 견종 데이터를 전달하기 위한 클로저
    public var didSelectBreed: ((String) -> Void)?
    
    private let allBreeds = [
        "가이아니즈", "그레이트 데인", "그레이트 피레니즈", "그레이하운드",
         "달마시안", "닥스훈트", "도베르만 핀셔", "라브라도 리트리버",
         "래브라도 리트리버", "말티즈", "미니어처 슈나우저", "바셋 하운드",
         "버니즈 마운틴 독", "벨기에 말리노이즈", "비글", "비숑 프리제",
         "블러드하운드", "보더 콜리", "보스턴 테리어", "복서",
         "브리타니 스패니얼", "샤페이", "세인트 버나드", "살루키",
         "시바견", "시베리안 허스키", "시추", "아메리칸 불도그",
         "아메리칸 핏불 테리어", "아메리칸 스태퍼드셔 테리어", "아프간 하운드",
         "알래스칸 맬러뮤트", "애완견", "오스트레일리안 셰퍼드", "위스트 하이랜드 화이트 테리어",
         "웰시 코기", "우에스턴 테리어", "이탈리안 그레이하운드", "잉글리시 불도그",
         "잉글리시 코커 스패니얼", "잉글리시 스프링거 스패니얼", "잉글리시 토이 스패니얼",
         "자이언트 슈나우저", "차우차우", "캐벌리에 킹 찰스 스패니얼", "케언 테리어",
         "콤모도르 데 본", "코커 스패니얼", "콜리", "카디건 웰시 코기",
         "클럼버 스패니얼", "치와와", "퍼그", "포메라니안",
         "프렌치 불도그", "골든 리트리버", "저먼 셰퍼드", "토이 푸들",
         "푸들", "펨브록 웰시 코기", "포인터", "파피용", "기타"
    ]
    
    // 모든 항목과 검색어에 따른 필터된 항목을 관리
    private lazy var breedsBehaviorRelay = BehaviorRelay<[String]>(value: allBreeds)
    private let disposeBag = DisposeBag()
    
    // MARK: - loadView
    public override func loadView() {
        self.view = breedSelectionView
    }
    
    // MARK: - viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        bindTableView()
        bindSearchBar()
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: - 테이블 뷰 바인딩
    private func bindTableView() {
        breedsBehaviorRelay
            .asDriver(onErrorDriveWith: .empty())
            .drive(self.breedSelectionView.breedTableView.rx.items(
                cellIdentifier: BreedTableViewCell.ID,
                cellType: BreedTableViewCell.self
            )) { row, element, cell in
                cell.configure(with: element)
            }
            .disposed(by: disposeBag)
        
        // 견종이 선택됬을 때 선택된 견종을 전달하고 이전 화면으로 이동
        breedSelectionView.breedTableView.rx.modelSelected(String.self)
            .withUnretained(self)
            .subscribe(onNext: { owner, text in
                self.didSelectBreed!(text)
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindSearchBar() {
        // 서치 바에 입력되는 텍스트
        let text = breedSelectionView.breedSearchBar.rx.text.orEmpty
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .distinctUntilChanged()

        // 입력된 텍스트에 따라 allBreeds에서 필터링 처리하고 결과를 breedsBehaviorRelay와 바인드
        text
            .withUnretained(self)
            .map { owner, text -> [String] in
                guard !text.isEmpty else { return self.allBreeds }
                return self.allBreeds.filter { $0.contains(text) }
            }
            .bind(to: breedsBehaviorRelay)
            .disposed(by: disposeBag)
    }
}
