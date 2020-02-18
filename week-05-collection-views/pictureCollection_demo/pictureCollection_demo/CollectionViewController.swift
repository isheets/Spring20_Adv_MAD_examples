//
//  CollectionViewController.swift
//  pictureCollection_demo
//
//  Created by Isaac Sheets on 2/18/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //data
    var albumImages = [String]()
    
    //constants for layout
    let spacing : CGFloat = 8
    let numberItemsPerRow : CGFloat = 3
    let spacingBetweenCells : CGFloat = 8

    override func viewDidLoad() {
        super.viewDidLoad()

        //populate array with image names
        for i in 1...20 {
            albumImages.append("album" + String(i))
        }
        
        //instantiate
        let layout = UICollectionViewFlowLayout()
        //configure layout
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        //apply to collection view
        collectionView.collectionViewLayout = layout
    }
    
    //size each item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //get total amount of empty space
        let totalSpacing = (2 * spacing) + ((numberItemsPerRow - 1) * spacingBetweenCells)
        
        let width = (collectionView.bounds.width - totalSpacing) / numberItemsPerRow
        
        return CGSize(width: width, height: width)
        
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //check identified
        if segue.identifier == "showDetail" {
            //get ref to destination controller
            let detailVC = segue.destination as! DetailViewController
            //get the cell
            let indexPath = collectionView.indexPath(for: sender as! CollectionViewCell)
            
            //set properties in destination
            detailVC.title = "Album #\(indexPath!.row + 1)"
            detailVC.imageName = albumImages[indexPath!.row]
        }
        
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
    
        // constructs UIImage and set source of imageView
        let image = UIImage(named: albumImages[indexPath.row])
        cell.imageView.image = image
        
        return cell
    }
    
    //set size for header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: 50, height: 40)
    }
    
    //set content for header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var header : HeaderView?
        
        if kind == UICollectionView.elementKindSectionHeader {
            header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as? HeaderView
            
            header?.headerLabel.text = "2019"
            
        }
        
        return header!
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
