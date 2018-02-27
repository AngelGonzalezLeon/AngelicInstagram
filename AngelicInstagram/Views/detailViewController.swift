//
//  detailViewController.swift
//  AngelicInstagram
//
//  Created by angel gonzalez on 2/26/18.
//  Copyright © 2018 angel gonzalez. All rights reserved.
//

import UIKit
import ParseUI
import Parse

class detailViewController: UIViewController {

    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var imageView: PFImageView!
    
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let post = post {
            
            let string = post.createdAt!.description
            
            let RFC3339DateFormatter = DateFormatter()
            RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
            RFC3339DateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZZZZZ"
            let date = RFC3339DateFormatter.date(from: string)
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "EEEE, MMM d, yyyy"
            //copy pasting to reuse instead of making this a function :DD
            if let imageFile : PFFile = post.media {
                imageFile.getDataInBackground(block: { (data, error) in
                    if error == nil {
                        DispatchQueue.main.async {
                            let image = UIImage(data: data!)
                            self.imageView.image = image
                        }
                    } else {
                        print(error!.localizedDescription)
                    }
                })
            }
            timestampLabel.text = dateFormatterPrint.string(from: date!)
            captionLabel.text = post["caption"] as? String
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
