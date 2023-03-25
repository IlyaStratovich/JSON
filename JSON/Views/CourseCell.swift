//
//  CourseCell.swift
//  JSON
//
//  Created by Илья Стратович on 25.03.23.
//

import UIKit

final class CourseCell: UITableViewCell {

    @IBOutlet var courseImage: UIImageView!
    @IBOutlet var courseNameLabel: UILabel!
    @IBOutlet var courseNumberOfLessons: UILabel!
    @IBOutlet var coursesNumberOfTests: UILabel!
    
    func configure(with course: Course) {
        courseNameLabel.text = course.name
        courseNumberOfLessons.text = "Number of lessons: \(course.numberOfLessons ?? 0)"
        coursesNumberOfTests.text = "Number of tests: \(course.numberOfTests ?? 0)"
        
        guard let imageData = try? Data(contentsOf: course.imageUrl!) else {return}
        courseImage.image = UIImage(data: imageData)
    }
    
}
