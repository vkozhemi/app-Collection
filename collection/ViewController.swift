//
//  ViewController.swift
//  D03
//
//  Created by Volodymyr KOZHEMIAKIN on 1/18/19.
//  Copyright © 2019 Volodymyr KOZHEMIAKIN. All rights reserved.
//

import UIKit

var count = 0

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    let array:[String] = ["https://www.nationalparks.org/sites/default/files/shutterstock_142351951.jpg",
                          "https://pre00.deviantart.net/429e/th/pre/f/2011/039/d/0/half_dome_sunset_by_allen59-d393l01.jpg",
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqvSPeFG3B-VToSBJ7sIcq8cBXqVsW6GNwqZx3kMvAUyIRRA_P",
                          "https://i.pinimg.com/originals/6e/f7/f4/6ef7f476e338bfbc4605c711cf2596a2.jpg"]

    override func viewDidLoad() {
        super.viewDidLoad()

        let itemSize = UIScreen.main.bounds.width/2 - 2
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        
        myCollectionView.collectionViewLayout = layout
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Number of views
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
  //Populate view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! myCell

        
        DispatchQueue.global().async { [weak self] in
            guard let str = self?.array[indexPath.row] else { return }
            guard let url: URL = URL(string: str) else { return }
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                            cell.myImageView.image = image
                            cell.activityMonitor.stopAnimating()
                            cell.activityMonitor.isHidden = true
                        
                        }
                    
                    
                    
                        count += 1
                    }
               
                if count == 4 {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
            else {
                self?.showAlertButtonTapped(patch :  (self?.array[indexPath.row])!)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? myCell {
            if let image = cell.myImageView.image {
                self.navigationController?.pushViewController(ImageViewController.create(label: "this is \(indexPath.row) image", image: image), animated: true)
            }
        }
    }

    
    func showAlertButtonTapped(patch : String) {
        let alert = UIAlertController(title: "Error", message: "Could not access to \(patch)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

}
