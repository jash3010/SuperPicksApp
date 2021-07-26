//
//  PopUpVC.swift
//  BetKing
//
//  Created by MAC on 26/07/21.
//

import UIKit

protocol popupDeleget {
    func didChangeIndex(index:Int)
}
class PopUpVC: UIViewController {

    @IBOutlet weak var dataTBl: UITableView!
    var dataARY=NSMutableArray()
    var popdel:popupDeleget?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTBL()
    }
    
    @IBAction func closeClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func setupTBL(){
        dataTBl.delegate = self
        dataTBl.dataSource = self
        dataTBl.separatorStyle = .none
        dataTBl.reloadData()
    }
}
extension PopUpVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataARY.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "PopupTBLCell", for: indexPath) as!  PopupTBLCell
        cell.selectionStyle = .none
        
        cell.titleLBL.text = "\(dataARY.object(at: indexPath.row))"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            self.popdel?.didChangeIndex(index: indexPath.row)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
