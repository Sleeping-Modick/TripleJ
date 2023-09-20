//
//  CalendarViewModel.swift
//  MeYouMeYou
//
//  Created by t2023-m0056 on 2023/09/20.
//

import Foundation

class CalendarViewModel {
    var dummyCalendarPostTitle =  (0...10).map { _ in "달력 게시글 제목 제목" }
    
    func getPostCount() -> Int {
        return dummyCalendarPostTitle.count
    }
    
    func getPost() -> [String] {
        return dummyCalendarPostTitle
    }
}
