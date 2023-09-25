//
//  CalendarViewController.swift
//  MeYouMeYou
//
//  Created by t2023-m0056 on 2023/09/20.
//

import FSCalendar
import SnapKit
import SwiftUI
import UIKit

class CalendarViewController: UIViewController {
    private let viewModel = CalendarViewModel()
    
    // MARK: Property
    private var calendarDdayLabel: UILabel = {
        var label = UILabel()
        label.text = "  D-Day 101  "
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.backgroundColor = UIColor(named: "PrimaryColor")
        label.clipsToBounds = true
        label.layer.cornerRadius = 12
        label.layer.borderWidth = 0
        return label
    }()
    
    private lazy var calendarView: FSCalendar = {
        let calendar = FSCalendar()
        calendar.dataSource = self
        calendar.delegate = self
        
        calendar.backgroundColor = .systemBackground
        
        calendar.layer.cornerRadius = Constant.cornerRadius
        
        // 첫 열을 월요일로 설정
        calendar.firstWeekday = 2
        // week 또는 month 가능
        calendar.scope = .month
        
        calendar.scrollEnabled = false
        calendar.locale = Locale(identifier: "en_KR")
        
        // 현재 달의 날짜들만 표기하도록 설정
        calendar.placeholderType = .none
        
        // 헤더뷰 설정
        calendar.headerHeight = 70
        calendar.appearance.headerDateFormat = "MM월"
        calendar.appearance.headerTitleColor = .black
        
        // 요일 UI 설정
        calendar.appearance.weekdayFont = UIFont.systemFont(ofSize: 12)
        calendar.appearance.weekdayTextColor = .black
        
        //
        calendar.appearance.selectionColor = UIColor(named: "SubPrimaryColor")
        
        // 날짜 UI 설정
        calendar.appearance.titleTodayColor = .red
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 16)
        calendar.appearance.subtitleFont = UIFont.systemFont(ofSize: 10)
        calendar.appearance.subtitleTodayColor = .black
        calendar.appearance.todayColor = UIColor(named: "PrimaryColor")
        
        // TODO: 확인
        // 토요일 라벨의 textColor를 blue로 설정
        calendar.calendarWeekdayView.weekdayLabels[5].textColor = .blue
        // 일요일 라벨의 textColor를 red로 설정
        calendar.calendarWeekdayView.weekdayLabels.last!.textColor = .red
        return calendar
    }()
    
    var postView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(named: "SubPrimaryColor")
        view.layer.cornerRadius = Constant.cornerRadius
        return view
    }()
    
    var postImageView: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "dummy")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = Constant.calendarBasicMargin
        return view
    }()
    
    var postTitleLabel: UILabel = {
        var label = UILabel()
        label.text = "준영"
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    var likeButton: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(systemName: "heart.fill")
        view.tintColor = .systemRed
        return view
    }()
    
    var postContentLabel: UILabel = {
        var label = UILabel()
        label.text = "내용"
        label.font = UIFont.systemFont(ofSize: 12)
        label.backgroundColor = UIColor(named: "CustomBackgroundColor")
        label.clipsToBounds = true
        label.layer.cornerRadius = Constant.cornerRadius
        return label
    }()
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setCollectionView()
    }
    
    lazy private var calendarCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        var view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.itemSize = CGSize(
            width: UIScreen.main.bounds.width * 0.21, height: UIScreen.main.bounds.height * 0.05)
                layout.minimumLineSpacing = 5
        layout.scrollDirection = .horizontal
        layout.collectionView?.isPagingEnabled = false
        view.decelerationRate = UIScrollView.DecelerationRate.fast
        view.backgroundColor = UIColor(named: "SubPrimaryColor")
        return view
    }()
    
    private func configureUI() {
        view.backgroundColor = UIColor(named: "CustomBackgroundColor")

        view.addSubview(calendarDdayLabel)
        view.addSubview(calendarView)
        
        view.addSubview(postView)
        postView.addSubview(postImageView)
        postView.addSubview(likeButton)
        postView.addSubview(postTitleLabel)
        postView.addSubview(postContentLabel)
        postView.addSubview(calendarCollectionView)
        
        calendarDdayLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constant.calendarBasicMargin)
        }
        
        calendarView.snp.makeConstraints {
            $0.top.equalTo(calendarDdayLabel.snp.bottom).inset(-Constant.calendarBasicMargin)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constant.calendarBasicMargin)
        }
        
        postView.snp.makeConstraints {
            $0.top.equalTo(calendarView.snp.bottom).inset(-Constant.calendarBasicMargin)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constant.calendarBasicMargin)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constant.calendarBasicMargin)
            $0.height.equalTo(UIScreen.main.bounds.height * 0.25)
        }
        
        postImageView.snp.makeConstraints {
            $0.leading.equalTo(postView).inset(10)
            $0.centerY.equalTo(postView)
            $0.width.equalTo(150)
            $0.height.equalTo(180)
        }
        
        likeButton.snp.makeConstraints {
            $0.top.trailing.equalTo(postView).inset(10)
            $0.width.height.equalTo(40)
        }
        
        postTitleLabel.snp.makeConstraints {
            $0.top.equalTo(postImageView)
            $0.leading.equalTo(postImageView.snp.trailing).inset(-10)
            $0.trailing.equalTo(likeButton.snp.leading).inset(-10)
        }
        
        postContentLabel.snp.makeConstraints {
            $0.top.equalTo(postTitleLabel.snp.bottom).inset(-10)
            $0.leading.equalTo(postImageView.snp.trailing).inset(-10)
            $0.trailing.equalTo(postView).inset(10)
            $0.height.equalTo(80)
        }
        
        calendarCollectionView.snp.makeConstraints {
            $0.top.equalTo(postContentLabel.snp.bottom).inset(-10)
            $0.leading.equalTo(postImageView.snp.trailing).inset(-10)
            $0.trailing.equalTo(postView).inset(10)
            $0.bottom.equalTo(postImageView)
            $0.height.equalTo(UIScreen.main.bounds.height * 0.05)
        }
    }
    
    private func setCollectionView() {
        calendarCollectionView.register(
            CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
        
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self
    }
}

extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getPostCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        guard let cell = calendarCollectionView.dequeueReusableCell(
            withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath)
                as? CalendarCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.bind(viewModel.getPost()[indexPath.row])
        return cell
    }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    // 공식 문서에서 레이아웃을 위해 아래의 코드 요구
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.updateConstraints { make in
            make.height.equalTo(bounds.height)
            // Do other updates
        }
        view.layoutIfNeeded()
    }
    
    // 오늘 cell에 subtitle 생성
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        switch dateFormatter.string(from: date) {
        case dateFormatter.string(from: Date()):
            return "Today"
            
        default:
            return nil
        }
    }
    
    // 일요일에 해당되는 모든 날짜의 색상 red로 변경
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date)
    -> UIColor? {
        let day = Calendar.current.component(.weekday, from: date) - 1
        
        if Calendar.current.shortWeekdaySymbols[day] == "Sun" {
            return .systemRed
        } else if Calendar.current.shortWeekdaySymbols[day] == "Sat" {
            return .systemBlue
        } else {
            return .label
        }
    }
}

extension CalendarViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>) {
          guard let layout = self.calendarCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
              return
          }
          // CollectionView Item Size
          let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
          
          // 이동한 x좌표 값과 item의 크기를 비교 후 페이징 값 설정
          let estimatedIndex = scrollView.contentOffset.x / cellWidthIncludingSpacing
          let index: Int
          
          // 스크롤 방향 체크
          // item 절반 사이즈 만큼 스크롤로 판단하여 올림, 내림 처리
          if velocity.x > 0 {
              index = Int(ceil(estimatedIndex))
          } else if velocity.x < 0 {
              index = Int(floor(estimatedIndex))
          } else {
              index = Int(round(estimatedIndex))
          }
          // 위 코드를 통해 페이징 될 좌표 값을 targetContentOffset에 대입
          targetContentOffset.pointee = CGPoint(x: CGFloat(index) * cellWidthIncludingSpacing - 20, y: 0)
      }
}

// SwiftUI를 활용한 미리보기
struct CalendarViewController_Previews: PreviewProvider {
    static var previews: some View {
        CalendarVCReprsentable().edgesIgnoringSafeArea(.all)
    }
}

struct CalendarVCReprsentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let calendarVC = CalendarViewController()
        return UINavigationController(rootViewController: calendarVC)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    typealias UIViewControllerType = UIViewController
}
