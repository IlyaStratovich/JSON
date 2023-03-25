//
//  ViewController.swift
//  JSON
//
//  Created by Илья Стратович on 23.03.23.
//

import UIKit

enum UserTap: String, CaseIterable {
    case showClown = "Show Clown 🤡"
    case clownJson = "Open Clown JSON"
    case coursesList = "Open Courses List"
}

enum Link: String, CaseIterable {
    case ImageURL
    case clownJson
    case coursesList
    
    var url: URL {
        switch self {
        case .ImageURL:
            return URL(string: "https://st2.depositphotos.com/1194063/6280/i/600/depositphotos_62801209-stock-photo-clown.jpg")!
        case .clownJson:
            return URL(string: "https://api.sunrisesunset.io/json?lat=38.907192&lng=-77.036873&timezone=UTC&date=today")!
        case .coursesList:
            return URL(string: "https://swiftbook.ru//wp-content/uploads/api/api_courses")!
        }
    }
}

enum Alert {
    case success
    case failed
    
    var title: String {
        switch self {
            
        case .success:
            return "Успех!"
        case .failed:
            return "Упс!"
        }
    }
        var message: String {
            switch self {
                
            case .success:
                return "Ура у тебя все получилось!"
            case .failed:
                return "Что-то пошло не так...проверь свой код"
            }
        }
    }

final class MainViewController: UIViewController, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        UserTap.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userAction", for: indexPath)
        guard let cell = cell as? UserAction else { return UICollectionViewCell() }
        cell.userActionLabel.text = userTaps[indexPath.item].rawValue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userTap = userTaps[indexPath.item]
        switch userTap {
        case .showClown:
            performSegue(withIdentifier: "showClown", sender: nil)
        case .clownJson:
            fetchClown()
        case .coursesList:
            performSegue(withIdentifier: "coursesList", sender: nil)
        }
    }

    private let userTaps = UserTap.allCases
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "coursesList" {
            guard let coursesListVC = segue.destination as? CoursesListViewController else {return}
            coursesListVC.fetchCoursesList()
        }
    }
    
    
    private func showAlert(withStatus status: Alert) {
        let alert = UIAlertController(
            title: status.title,
            message: status.message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        DispatchQueue.main.async {
            [unowned self] in
            present(alert, animated: true)
        }
    }
    
}
    extension MainViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
        }
    }
    
    extension MainViewController {
        private func fetchClown() {
//            guard let url = Link.clownJson.url else { return }
            URLSession.shared.dataTask(with: Link.clownJson.url) { data, _, error in
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

