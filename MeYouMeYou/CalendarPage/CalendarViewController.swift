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
    // MARK: Property
    var dummyCalendarPostTitle =  (0...10).map { _ in "달력 게시글 제목 제목" }
    
    var calendarDdayLabel: UILabel = {
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
    
    lazy var calendarView: FSCalendar = {
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
        //            calendar.appearance.weekdayFont = UIFont.font(.pretendardRegular, ofSize: 12)
        //            calendar.appearance.weekdayTextColor = .black
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
        
        // 토요일 라벨의 textColor를 blue로 설정
        calendar.calendarWeekdayView.weekdayLabels[5].textColor = .blue
        // 일요일 라벨의 textColor를 red로 설정
        calendar.calendarWeekdayView.weekdayLabels.last!.textColor = .red
        return calendar
    }()
    
    var calendarCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        var view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.itemSize = CGSize(
            width: (UIScreen.main.bounds.width / 2) - 5, height: (UIScreen.main.bounds.width / 2) - 5)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .horizontal
        view.layer.cornerRadius = Constant.cornerRadius
        view.backgroundColor = UIColor(named: "SubPrimaryColor")
        return view
    }()
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setCollectionView()
    }
    
    func configureUI() {
        view.backgroundColor = UIColor(named: "CustomBackgroundColor")
        
        view.addSubview(calendarDdayLabel)
        view.addSubview(calendarView)
        view.addSubview(calendarCollectionView)
        
        calendarDdayLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constant.calendarBasicMargin)
        }
        
        calendarView.snp.makeConstraints {
            $0.top.equalTo(calendarDdayLabel.snp.bottom).inset(-Constant.calendarBasicMargin)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constant.calendarBasicMargin)
        }
        
        calendarCollectionView.snp.makeConstraints {
            $0.top.equalTo(calendarView.snp.bottom).inset(-Constant.calendarBasicMargin)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constant.calendarBasicMargin)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constant.calendarBasicMargin)
            $0.height.equalTo(200)
        }
    }
    
    func setCollectionView() {
        calendarCollectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
        
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self
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

extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyCalendarPostTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        var cell = calendarCollectionView.dequeueReusableCell(
            withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as? CalendarCollectionViewCell
        cell?.bind(dummyCalendarPostTitle[indexPath.row])
        return cell ?? UICollectionViewCell()
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
