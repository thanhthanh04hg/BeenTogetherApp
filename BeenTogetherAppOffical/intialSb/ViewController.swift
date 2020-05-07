//
//  ViewController.swift
//  BeenTogetherAppOffical
//
//  Created by Macbook on 4/24/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    var window : UIWindow?
//    var delegate : Delegate?
   @IBOutlet var pageControl: UIPageControl!
    var final : String = "final"
    @IBOutlet var collView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CollectionViewCell1", bundle: nil)
        collView.register(nib, forCellWithReuseIdentifier: "CollectionViewCell1")
        let nib2=UINib(nibName: "CollectionViewCell2", bundle: nil)
        collView.register(nib2, forCellWithReuseIdentifier: "CollectionViewCell2")
        
        collView.dataSource=self
        collView.delegate=self
        pageControl.hidesForSinglePage = true
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width:self.view.bounds.width, height: self.view.bounds.height/2)
        collView.collectionViewLayout = layout
        collView.showsHorizontalScrollIndicator = false
        collView.isPagingEnabled = true
        
//        UserDefaults.standard.set(false, forKey: "isDateSet")
        
    }
//    push screen and delegate
    
    
    

}
extension ViewController : UICollectionViewDataSource,UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{
     
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 2
        }

        func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            self.pageControl.currentPage=indexPath.section
            print(indexPath.item)
    //        self.pageControl.currentPage = 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if(indexPath.item == 0) {
                guard let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier:"CollectionViewCell1", for: indexPath) as? CollectionViewCell1 else {
                    return UICollectionViewCell()
                }
                
    //            cell1.delegate=self
                return cell1
            }
            else {
                guard let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell2", for: indexPath) as? CollectionViewCell2 else {
                    return UICollectionViewCell()
                }
                return cell2
            }
          
            
        }
    //    size of collection view
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        return CGSize(width: self.view.bounds.width, height: self.view.bounds.height/2)
    //    }
    @IBAction func startMainView(_ sender: Any) {
            let sb=UIStoryboard.init(name: "MainSb", bundle: nil)
            let mainView=sb.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
    //        self.delegate=mainView
    //        delegate?.passData(final)
            UserDefaults.standard.set(true, forKey: "isDateSet")
            self.navigationController?.pushViewController(mainView, animated: true)
    //        print (final)
        print ("diplay")
            
        }
    
}
//extension ViewController : PassStrCell{
//    func passStrCell(_ lbl: String) {
//        final=lbl
//    }
//}
//
//protocol PassStrCell {
//    func passStrCell(_ lbl : String)
//}
