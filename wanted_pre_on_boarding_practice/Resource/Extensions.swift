//
//  Extensions.swift
//  wanted_PreOnBoarding_practice
//
//  Created by 김성훈 on 2022/06/17.
//

import Foundation

extension Bundle {
    
    // 생성한 .plist 파일 경로 불러오기
    var WEATHER_API_KEY: String {
        guard let file = self.path(forResource: "WeatherInfo", ofType: "plist") else { return "" }
        
        // .plist를 딕셔너리로 받아오기
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        
        // 딕셔너리에서 값 찾기
        guard let key = resource["WEATHER_API_KEY"] as? String else {
            fatalError("plist-file-name.plist에 ACCESS_KEY를 입력해주세요! ")
        }
        return key
    }
}

