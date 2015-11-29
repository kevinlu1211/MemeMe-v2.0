//
//  MemeShowViewControllerFromTV.swift
//  MemeMe v2.0
//
//  Created by Kevin Lu on 29/11/2015.
//  Copyright © 2015 Kevin Lu. All rights reserved.
//

import UIKit

class MemeShowViewControllerFromTableView: UIViewController {

    @IBOutlet weak var memeImageView: UIImageView!
    var memeImage : UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "unwindToTableView")
        self.navigationItem.rightBarButtonItem = doneButton
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        memeImageView.image = memeImage
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func unwindToTableView() {
        self.dismissViewControllerAnimated(true, completion: nil)
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
