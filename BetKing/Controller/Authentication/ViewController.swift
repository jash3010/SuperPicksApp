//
//  ViewController.swift
//  SuperPicksApp
//
//  Created by MAC  on 12/07/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var barBTN: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }

    @IBAction func barBTNTApped(_ sender: Any) {
        
    }
    
    @IBAction func signINBTNTApped(_ sender: Any) {
        
       
    }
    @IBAction func playForFreeBTN(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        vc.isBet = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

