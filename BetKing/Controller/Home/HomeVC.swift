//
//  HomeVC.swift
//  BetKing
//
//  Created by MAC on 22/07/21.
//

import UIKit
import Toast_Swift

class HomeVC: UIViewController {
    @IBOutlet weak var pridictionView: UIView!
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var rightBTN: UIButton!
    @IBOutlet weak var leftBTN: UIButton!
    @IBOutlet weak var homeTBL: UITableView!
    var tableHeight = 210
    
    var isBet = false
    
    var playData: PlayModel?
    var RoundAry = [Itemss]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTBL()
        getPlayData()
        
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
        return self.playData?.payload?.items?[0].externalEvents?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isBet{
            let cell  = tableView.dequeueReusableCell(withIdentifier: "BetsTVCell", for: indexPath) as!  BetsTVCell
            cell.selectionStyle = .none
            cell.backView.addShadow()
            return cell
            
        }else{
            let cell  = tableView.dequeueReusableCell(withIdentifier: "homeTVCell", for: indexPath) as!  homeTVCell
            cell.selectionStyle = .none
            cell.backView.addBottomShadow()
            
            
            cell.firstTeamName.text = self.playData?.payload?.items?[0].externalEvents?[indexPath.row].eventName
            
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

extension HomeVC{
    
    func getPlayData(){
        
        WebService.shared.callGetAPIForData(api: Apis.play_api_ext, showIndicator: true) { (response, error)
            in
            if error == nil{
                print(response as Any)
                
                let decoder = JSONDecoder()
                
                do {
                    self.playData = try decoder.decode(PlayModel.self, from: response ?? Data())
                    
                    let c = (self.playData?.payload?.items?[0].externalEvents?.count ?? 0)
                    if self.isBet{
                        let h = CGFloat((self.tableHeight * c) - (c * 70))
                        self.tblHeight.constant = h
                        self.viewHeight.constant = 0
                        self.pridictionView.isHidden = true
                    }else {
                        self.tblHeight.constant = CGFloat((self.tableHeight * c) + (c * 20))
                        self.pridictionView.addBottomShadow()
                        self.viewHeight.constant = 215
                        self.pridictionView.isHidden = false
                    }
                    
                    if let items = self.playData?.payload?.items{
                        for item in items {
                            if let externalEvents = item.externalEvents{
                                var externalEvent: [ExternalEvent]
                                externalEvent = externalEvents
                                
                                var isFounded = false
                                for index in 0...externalEvent.count {
                                    
                                    for secondIndex in 0...externalEvent.count{
                                        
                                        if externalEvent[index].id != externalEvent[secondIndex].matchID{
                                            
                                            if externalEvent[index].matchID == externalEvent[secondIndex].matchID{
                                                
                                                let fm = MatchDic(id: externalEvent[index].id, drawID: externalEvent[index].drawID, orderIndex: externalEvent[index].orderIndex, eventName: externalEvent[index].eventName, eventDate: externalEvent[index].eventDate, externalID: externalEvent[index].externalID, teamID: externalEvent[index].teamID, matchID: externalEvent[index].matchID)
                                                
                                                let sm = MatchDic(id: externalEvent[secondIndex].id, drawID: externalEvent[secondIndex].drawID, orderIndex: externalEvent[secondIndex].orderIndex, eventName: externalEvent[secondIndex].eventName, eventDate: externalEvent[secondIndex].eventDate, externalID: externalEvent[secondIndex].externalID, teamID: externalEvent[secondIndex].teamID, matchID: externalEvent[secondIndex].matchID)
                                                
                                                
                                                let d = ExternalEventsss(firstTeam: fm, secondTeam: sm)
                                                
                                                self.RoundAry.append(Itemss(externalEvents: d, matches: item.matches, result: item.result, id: item.id, drawDate: item.drawDate, drawName: item.drawName, betStartDate: item.betStartDate, betEndDate: item.betEndDate, processingStatusID: item.processingStatusID))
                                                
//                                                externalEvent.remove(at: index)
//                                                externalEvent.remove(at: secondIndex)
                                                
                                                isFounded = true
                                                break
                                            }
                                        }
                                    }
                                    if isFounded{
                                        break
                                    }
                                }
                            }
                        }
                    }
                    self.homeTBL.reloadData()
                    print(self.playData)
                } catch {
                    self.view.makeToast("Can not read data")
                }
            }else{
                print(error?.localizedDescription as Any)
            }
        }
    }
}
