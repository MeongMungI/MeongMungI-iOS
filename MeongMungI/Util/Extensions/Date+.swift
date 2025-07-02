//
//  Date+.swift
//  MeongMungI
//
//  Created by 7aeHoon on 7/2/25.
//

import Foundation

extension Date {
    /// 사용자의 현재 시각(기본값: `Date()`)과 비교해
    /// "방금" / "N분 전" / "N시간 전" / "MM/dd" 로 변환합니다.
    func relativeString(
        reference now: Date = Date(),
        calendar: Calendar = .current
    ) -> String {
        // 1. 같은 연-월-일-시-분(즉 1분 이내)일 때 ➜ "방금"
        if calendar.isDate(self, equalTo: now, toGranularity: .minute) {
            return "방금"
        }
        
        // 2. 같은 연-월-일-시(1분‥59분 차이) ➜ "N분 전"
        if calendar.isDate(self, equalTo: now, toGranularity: .hour) {
            let minutes = calendar.dateComponents([.minute], from: self, to: now).minute ?? 0
            return "\(minutes)분 전"
        }
        
        // 3. 같은 연-월-일(1‥23시간 차이) ➜ "N시간 전"
        if calendar.isDate(self, equalTo: now, toGranularity: .day) {
            let hours = calendar.dateComponents([.hour], from: self, to: now).hour ?? 0
            return "\(hours)시간 전"
        }
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = .current
        formatter.dateFormat = calendar.isDate(self, equalTo: now, toGranularity: .year)
        ? "MM/dd"
        : "yyyy/MM/dd"
        
        return formatter.string(from: self)
    }
}
