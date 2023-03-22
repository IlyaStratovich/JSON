//
//  ViewController.swift
//  JSON
//
//  Created by Илья Стратович on 22.03.23.
//

import UIKit

final class ViewController: UICollectionViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userAction", for: indexPath)
        return cell
    }
}

