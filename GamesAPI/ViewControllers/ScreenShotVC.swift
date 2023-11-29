//
//  ScreenShotVC.swift
//  GamesAPI
//
//  Created by Yudiz-subhranshu on 26/05/23.
//

import UIKit
import Kingfisher

class ScreenShotVC: UIViewController {
    @IBOutlet var OpCollectionView: UICollectionView!
    var screebShotList = [String]()
    var ScreenShotPosition = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        OpCollectionView.scrollToItem(at: IndexPath(item: ScreenShotPosition, section: 0), at: .right, animated: false)
        OpCollectionView.layoutSubviews()
    }
}

//MARK: - CollectionView Delegate Methods
extension ScreenShotVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screebShotList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = OpCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageShowCell
        cell.imageView.kf.setImage(with: URL(string: screebShotList[indexPath.row]), placeholder: UIImage(named: "download"))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! ImageShowCell
        cell.scrollView.setZoomScale(1.0, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! ImageShowCell
        cell.scrollView.setZoomScale(1.0, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}
