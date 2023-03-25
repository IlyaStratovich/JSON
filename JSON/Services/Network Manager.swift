//
//  Network Manager.swift
//  JSON
//
//  Created by Илья Стратович on 25.03.23.
//

import Foundation

enum Link: String, CaseIterable {
    case ImageURL
    case someJson
    case coursesList
    
    var url: URL {
        switch self {
        case .ImageURL:
            return URL(string: "https://st2.depositphotos.com/1194063/6280/i/600/depositphotos_62801209-stock-photo-clown.jpg")!
        case .someJson:
            return URL(string: "https://api.sunrisesunset.io/json?lat=38.907192&lng=-77.036873&timezone=UTC&date=today")!
        case .coursesList:
            return URL(string: "https://swiftbook.ru//wp-content/uploads/api/api_courses")!
        }
    }
}

extension MainViewController {
    func fetchSomeJson() {
        URLSession.shared.dataTask(with: Link.someJson.url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let course = try decoder.decode(FirstCourse.self, from: data)
                print(course)
                self.showAlert(withStatus: .success)
            } catch let error {
                print(error.localizedDescription)
                self.showAlert(withStatus: .failed)
            }
        }.resume()
    }
}
