//
//  Weather.swift
//  wanted_pre_on_boarding_practice
//
//  Created by 김성훈 on 2022/06/18.
//

import Foundation

struct WeatherModel: Codable {
    var weather: [Weather]
    let main: Main
    let name: String
}

struct Main: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

// API url 에 넣는 city 값
let CityList = [
    "Gongju", "Gwangju", "Gumi", "Gunsan", "Daegu", "Daejeon",
    "Mokpo", "Busan", "Seosan", "Seoul", "Sokcho", "suwon", "Iksan", "Suncheon",
    "Ulsan", "Jeonju", "Jeju", "Cheonan", "Cheongju", "Chuncheon"
]

// API 값 받으면 return 하는 city name -> 한글 name 으로 변경
var CityKoreaListDic: [[String: String]] = [
    ["Gongju": "공주"], ["Mokpo": "목포"], ["Gumi": "구미"], ["Busan": "부산"], ["Seosan City": "서산"], ["Seoul": "서울"], ["Daegu": "대구"], ["Gwangju": "광주"], ["Gunsan": "군산"], ["Daejeon": "대전"], ["Sokcho": "속초"], ["Iksan": "익산"], ["Suwon-si": "수원"], ["Suncheon": "순천"], ["Ulsan": "울산"], ["Jeonju": "전주"], ["Jeju City": "제주"], ["Cheonan": "천안"], ["Cheongju-si": "청주"], ["Chuncheon": "춘천"]
]
