//
//  HomeVC.swift
//  BetKing
//
//  Created by MAC on 22/07/21.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet weak var pridictionView: UIView!
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var rightBTN: UIButton!
    @IBOutlet weak var leftBTN: UIButton!
    @IBOutlet weak var homeTBL: UITableView!
    var tableHeight = 210
    
    var isBet = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTBL()
        if isBet{
            tblHeight.constant = CGFloat(tableHeight * 3 - (4 * 70))
            viewHeight.constant = 0
            pridictionView.isHidden = true
        }else {
            tblHeight.constant = CGFloat(tableHeight * 3 + (4 * 20))
            pridictionView.addBottomShadow()
            viewHeight.constant = 215
            pridictionView.isHidden = false
        }
        
   
 
        
    }
    
    func setupTBL(){
        homeTBL.delegate = self
        homeTBL.dataSource = self
        homeTBL.register(UINib(nibName: "homeTVCell", bundle: nil), forCellReuseIdentifier: "homeTVCell")
        homeTBL.register(UINib(nibName: "BetsTVCell", bundle: nil), forCellReuseIdentifier: "BetsTVCell")
        homeTBL.reloadData()
    
    }
    @IBAction func leftBTNTapped(_ sender: Any) {
        if isBet{
            
        }
        
    }
    @IBAction func rightBTNTapped(_ sender: Any) {
    }
    
}
extension HomeVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isBet{
                   let cell  = tableView.dequeueReusableCell(withIdentifier: "BetsTVCell", for: indexPath) as!  BetsTVCell
            cell.backView.addShadow()
            return cell
            
        }else{
            let cell  = tableView.dequeueReusableCell(withIdentifier: "homeTVCell", for: indexPath) as!  homeTVCell
            cell.backView.addBottomShadow()
            return cell
        }
    

       

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if isBet{
            return CGFloat(tableHeight - 70)
        }else {
            return CGFloat(tableHeight + 20)
            
        }
        
       
    }
    
    
}
