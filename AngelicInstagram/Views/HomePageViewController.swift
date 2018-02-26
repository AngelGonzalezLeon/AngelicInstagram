//
//  HomePageViewController.swift
//  AngelicInstagram
//
//  Created by angel gonzalez on 2/23/18.
//  Copyright © 2018 angel gonzalez. All rights reserved.
//

import UIKit
import Parse

class HomePageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func logoutButton(_ sender: Any) {
        print("logout button pressed and received")
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
        
    }
    @IBAction func composeButton(_ sender: Any) {
        self.performSegue(withIdentifier: "composerSegue", sender: nil)
    }
    
}
