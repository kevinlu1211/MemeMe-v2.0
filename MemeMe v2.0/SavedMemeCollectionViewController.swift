//
//  SavedMemeCollectionViewController.swift
//  MemeMe v2.0
//
//  Created by Kevin Lu on 27/11/2015.
//  Copyright © 2015 Kevin Lu. All rights reserved.
//

import UIKit
private let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
private let reuseIdentifier = "memeCell"

class SavedMemeCollectionViewController: UICollectionViewController  {
    
    @IBOutlet weak var flowLayout : UICollectionViewFlowLayout!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        let space = 3.0 as CGFloat
        let width = (self.view.frame.size.width - (2 * space))/space
        let height = (self.view.frame.size.height - (2 * space))/space
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        
        if (width > height) {
            flowLayout.itemSize = CGSizeMake(height, height)
        } else {
            flowLayout.itemSize  = CGSizeMake(width, width)
        }
        

        
//        // Register cell classes
//        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView?.reloadData()
        print("HI")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return appDelegate.memes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> MemeCollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MemeCollectionViewCell
    
        
//        
//        // Configure the dimensions
//        let screenWidth = self.collectionView!.bounds.size.width
//        let cellWidth = screenWidth/3
//        let cellHeight = cellWidth
//        
//        // Configure the imageView
//        cell.memeImage.frame.size.width = cellWidth
//        cell.memeImage.frame.size.height = cellHeight
        
        // Configure the cell
        cell.memeImage.image = appDelegate.memes[indexPath.row].memeImage
//        print("CollectionViewCell :")
//        print(cell.memeImage.frame)
//        print(cell.frame)
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
       
        // Presenting the VC by pushing it onto the stack
        let memeShowViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeShowViewControllerFromCollectionView") as! MemeShowViewControllerFromCollectionView
        memeShowViewController.memeImage = appDelegate.memes[indexPath.row].memeImage
        self.navigationController!.pushViewController(memeShowViewController, animated: true)
        
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
