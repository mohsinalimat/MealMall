//
//  FeaturedCarouselDatasource.swift
//  MealMall
//
//  Created by Tim on 22.10.2017.
//  Copyright © 2017 Tim. All rights reserved.
//

import UIKit
import CoreData

let featuredCellWidth: CGFloat = 195.0

class FeaturedCarouselDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate  {

    var items = [FeatItem]()
    
    override init() {
        super.init()
        loadItems()
    }
    
    func loadItems() {
        attemptFetch()
    }
    
    func attemptFetch() {
        let fetchRequest: NSFetchRequest<FeatItem> = FeatItem.fetchRequest()
        let sort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors =  [sort]

        guard let items = DataManager.fetch(fetchRequest: fetchRequest) else {
            return
        }
        self.items = items
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedItemCell.ID, for: indexPath) as! FeaturedItemCell
        
        cell.image.image = items[indexPath.row].image as! UIImage
        cell.nameLabel.text = items[indexPath.row].name!
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 195.0, height: 120)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        var offset = scrollView.contentOffset
        let cellWithGap = featuredCellWidth + CarouselHeaderCell.itemGap
        let integerNumberOfCells = round(offset.x / cellWithGap)
        var ttr = cellWithGap * integerNumberOfCells
        offset.x = ttr
        scrollView.setContentOffset(offset, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            if kind == UICollectionElementKindSectionHeader {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CarouselHeaderCell.startingGapID, for: indexPath) as! UICollectionReusableView

                return header
            }
        }
        return UICollectionReusableView(frame: CGRect.zero)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: 10, height: 120)
        }
        return CGSize.zero
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let viewController = UIViewController()
//    }
    
}
