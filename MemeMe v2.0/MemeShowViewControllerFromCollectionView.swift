//
//  MemeShowViewController.swift
//  MemeMe v2.0
//
//  Created by Kevin Lu on 29/11/2015.
//  Copyright © 2015 Kevin Lu. All rights reserved.
//

import UIKit

class MemeShowViewControllerFromCollectionView: UIViewController {
    
    @IBOutlet weak var memeImageView: UIImageView!

    var memeImage : UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let tapView: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "navBarHide")
        self.tabBarController!.tabBar.hidden = true
        memeImageView.image = memeImage
        view.addGestureRecognizer(tapView)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController!.tabBar.hidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func navBarHide() {
        if (self.navigationController?.navigationBar.hidden == true) {
            self.navigationController?.navigationBar.hidden = false
        } else {
            self.navigationController?.navigationBar.hidden = true
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
