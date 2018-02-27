//
//  HomePageViewController.swift
//  AngelicInstagram
//
//  Created by angel gonzalez on 2/23/18.
//  Copyright © 2018 angel gonzalez. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomePageViewController: UIViewController, UITableViewDataSource,UITableViewDelegate   {
    
    
    var refreshControl: UIRefreshControl!
    @IBOutlet weak var homeTableView: UITableView!
    
    var posts : [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomePageViewController.didPullToRefresh(_:)), for: UIControlEvents.valueChanged)
        homeTableView.insertSubview(refreshControl, at: 0)
        
        homeTableView.rowHeight = UITableViewAutomaticDimension
        homeTableView.estimatedRowHeight = 300
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        getPosts()
    }
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        getPosts()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        print(posts[indexPath.row].caption)
        print(posts[indexPath.row].media)
        
        cell.captionLabel.text = posts[indexPath.row].caption
        if let imageFile : PFFile = posts[indexPath.row].media {
            imageFile.getDataInBackground(block: { (data, error) in
                if error == nil {
                    DispatchQueue.main.async {
                        // Async main thread
                        let image = UIImage(data: data!)
                        cell.photoView.image = image
                    }
                } else {
                    print(error!.localizedDescription)
                }
            })
        }
        
        return cell
    }
    func getPosts()
    {
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.limit = 20
        
        query?.findObjectsInBackground(block: { (posts : [PFObject]?, error: Error?) -> Void in
            
            if let posts = posts {
                //print("post iflet works")
                self.posts = posts as! [Post]
                self.homeTableView.reloadData()
                self.refreshControl.endRefreshing()
                print("getPosts sucessful")
            } else {
                // handle error
                print("getPosts unsucessful")
            }
        })
        self.homeTableView.reloadData()

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
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let cell = sender as? UITableViewCell {
            if let indexPath = homeTableView.indexPath(for: cell) {
                let post = posts[indexPath.row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.post = post
            }
        }
    }
 */
    
}
