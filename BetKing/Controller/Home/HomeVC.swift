//
//  HomeVC.swift
//  BetKing
//
//  Created by MAC on 22/07/21.
//

import UIKit
import Toast_Swift

class HomeVC: UIViewController,popupDeleget {
    @IBOutlet weak var pridictionView: UIView!
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var rightBTN: UIButton!
    @IBOutlet weak var leftBTN: UIButton!
    @IBOutlet weak var homeTBL: UITableView!
    @IBOutlet weak var sportNameLBL: UILabel!
    var tableHeight = 210
    
    var isBet = false
    
    var playData: PlayModel?
    var RoundAry = [Itemss]()
    var currentRoundAry = [Itemss]()
    var currentname = ""
    var nameARY = NSMutableArray()
    var nameCurrentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTBL()
        homeTBL.isHidden = true
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
      
        nameCurrentIndex = nameCurrentIndex - 1
        if nameCurrentIndex == 0{
            leftBTN.isHidden = true
        }else{
            rightBTN.isHidden = false
        }
        reloadNewData(currentIndex: nameCurrentIndex)
        
    }
    @IBAction func rightBTNTapped(_ sender: Any) {
        
        nameCurrentIndex = nameCurrentIndex + 1
        if nameCurrentIndex == nameARY.count-1{
            rightBTN.isHidden = true
        }else {
            leftBTN.isHidden = false
        }
        reloadNewData(currentIndex: nameCurrentIndex)
    }
    @IBAction func optionClick(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopUpVC") as! PopUpVC
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.dataARY = nameARY
        vc.popdel = self
        self.present(vc, animated: true, completion: nil)
    }
    func didChangeIndex(index:Int){
        
        nameCurrentIndex = index
        if nameCurrentIndex == nameARY.count-1{
            rightBTN.isHidden = true
        }else if nameCurrentIndex == 0{
            leftBTN.isHidden = true
        }else{
            rightBTN.isHidden = false
            leftBTN.isHidden = false
        }
        
        reloadNewData(currentIndex: index)
    }
    func reloadNewData(currentIndex:Int) {
        
        self.currentRoundAry.removeAll()
        self.currentname = "\(self.nameARY.object(at: currentIndex))"
        self.sportNameLBL.text = self.currentname
        for i in 0..<self.RoundAry.count{
            print(self.RoundAry[i].drawName!)
            if self.RoundAry[i].drawName! == self.currentname && self.RoundAry[i].result != nil{
                print(self.RoundAry[i].drawName!)
                self.currentRoundAry.append(self.RoundAry[i])
            }
        }
       // print(self.currentRoundAry.count)
       if self.isBet{
            let h = CGFloat((self.tableHeight * self.currentRoundAry.count))
            self.tblHeight.constant = h
            self.viewHeight.constant = 0
            self.pridictionView.isHidden = true
        }else {
            self.tblHeight.constant = CGFloat((self.tableHeight * self.currentRoundAry.count) + (self.currentRoundAry.count * 20))
            self.pridictionView.addBottomShadow()
            self.viewHeight.constant = 215
            self.pridictionView.isHidden = false
        }
        //print( self.currentRoundAry.count)
        self.homeTBL.reloadData()
    }
    
}
extension HomeVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentRoundAry.count//self.playData?.payload?.items?[0].externalEvents?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isBet{
            let cell  = tableView.dequeueReusableCell(withIdentifier: "BetsTVCell", for: indexPath) as!  BetsTVCell
            cell.selectionStyle = .none
            cell.backView.addShadow()
            cell.firstTeamName.text = self.currentRoundAry[indexPath.row].externalEvents!.firstTeam!.eventName!
            cell.secondTeamName.text = self.currentRoundAry[indexPath.row].externalEvents!.secondTeam!.eventName!
            cell.firstTeamRank.text = "\(self.currentRoundAry[indexPath.row].externalEvents!.firstTeam!.orderIndex!)"
            cell.secondTeamRank.text = "\(self.currentRoundAry[indexPath.row].externalEvents!.secondTeam!.orderIndex!)"
            return cell
            
        }else{
            let cell  = tableView.dequeueReusableCell(withIdentifier: "homeTVCell", for: indexPath) as!  homeTVCell
            cell.selectionStyle = .none
            cell.backView.addBottomShadow()
            
            cell.firstTeamName.text = self.currentRoundAry[indexPath.row].externalEvents!.firstTeam!.eventName!
            cell.secondTeamName.text = self.currentRoundAry[indexPath.row].externalEvents!.secondTeam!.eventName!
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if isBet{
            return CGFloat(tableHeight)
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
                    if let items = self.playData?.payload?.items{
                        for item in items {
                            if let externalEvents = item.externalEvents{
                                var externalEvent: [ExternalEvent]
                                externalEvent = externalEvents
                               
                                
                                for index in 0..<externalEvents.count{
                                    
                                    let matchid = "\(externalEvents[index].matchID!)"
                                    var ischeckavaialbe = false
                                    for j in 0..<self.RoundAry.count{
                                        let checkid = "\(String(describing: self.RoundAry[j].externalEvents?.firstTeam?.matchID!))"
                                        if matchid == checkid{
                                            ischeckavaialbe = true
                                        }
                                    }
                                    if ischeckavaialbe == false{
                                        
                                        let fm = MatchDic(id: externalEvent[index].id, drawID: externalEvent[index].drawID, orderIndex: externalEvent[index].orderIndex, eventName: externalEvent[index].eventName, eventDate: externalEvent[index].eventDate, externalID: externalEvent[index].externalID, teamID: externalEvent[index].teamID, matchID: externalEvent[index].matchID)
                                        var isFounded = false
                                        for secondIndex in index+1..<externalEvents.count{
                                            
                                            let smatchid = "\(externalEvents[secondIndex].matchID!)"
                                            
                                            if matchid == smatchid{
                                                isFounded = true
                                                let sm = MatchDic(id: externalEvent[secondIndex].id, drawID: externalEvent[secondIndex].drawID, orderIndex: externalEvent[secondIndex].orderIndex, eventName: externalEvent[secondIndex].eventName, eventDate: externalEvent[secondIndex].eventDate, externalID: externalEvent[secondIndex].externalID, teamID: externalEvent[secondIndex].teamID, matchID: externalEvent[secondIndex].matchID)
                                                
                                                let d = ExternalEventsss(firstTeam: fm, secondTeam: sm)
                                                
                                                self.RoundAry.append(Itemss(externalEvents: d, matches: item.matches, result: item.result, id: item.id, drawDate: item.drawDate, drawName: item.drawName, betStartDate: item.betStartDate, betEndDate: item.betEndDate, processingStatusID: item.processingStatusID))
                                            }
                                            if isFounded{
                                                break
                                            }
                                            
                                        }
                                    }
                                }
                                
//                                var isFounded = false
//                                for index in 0...externalEvent.count {
//
//                                    for secondIndex in 0...externalEvent.count{
//
//                                        if externalEvent[index].id != externalEvent[secondIndex].matchID{
//
//                                            if externalEvent[index].matchID == externalEvent[secondIndex].matchID{
//
//                                                let fm = MatchDic(id: externalEvent[index].id, drawID: externalEvent[index].drawID, orderIndex: externalEvent[index].orderIndex, eventName: externalEvent[index].eventName, eventDate: externalEvent[index].eventDate, externalID: externalEvent[index].externalID, teamID: externalEvent[index].teamID, matchID: externalEvent[index].matchID)
//
//                                                let sm = MatchDic(id: externalEvent[secondIndex].id, drawID: externalEvent[secondIndex].drawID, orderIndex: externalEvent[secondIndex].orderIndex, eventName: externalEvent[secondIndex].eventName, eventDate: externalEvent[secondIndex].eventDate, externalID: externalEvent[secondIndex].externalID, teamID: externalEvent[secondIndex].teamID, matchID: externalEvent[secondIndex].matchID)
//
//
//                                                let d = ExternalEventsss(firstTeam: fm, secondTeam: sm)
//
//                                                self.RoundAry.append(Itemss(externalEvents: d, matches: item.matches, result: item.result, id: item.id, drawDate: item.drawDate, drawName: item.drawName, betStartDate: item.betStartDate, betEndDate: item.betEndDate, processingStatusID: item.processingStatusID))
//
////                                                externalEvent.remove(at: index)
////                                                externalEvent.remove(at: secondIndex)
//
//                                                isFounded = true
//                                                break
//                                            }
//                                        }
//                                    }
//                                    if isFounded{
//                                        break
//                                    }
//                                }
                            }
                        }
                    }
                    
                    
                    
                    if let items = self.playData?.payload?.items{
                        for i in 0..<items.count {
                            let name = items[i].drawName
                            if items[i].result != nil{
                                self.nameARY.add(name!)
                            }
                        }
                    }
                    self.currentname = "\(self.nameARY.object(at: 0))"
                    self.sportNameLBL.text = self.currentname
                    self.leftBTN.isHidden = true
                    for i in 0..<self.RoundAry.count{
                        print(self.RoundAry[i].drawName!)
                        if self.RoundAry[i].drawName! == self.currentname && self.RoundAry[i].result != nil{
                            print(self.RoundAry[i].drawName!)
                            self.currentRoundAry.append(self.RoundAry[i])
                        }
                    }
                    print(self.nameARY)
                   if self.isBet{
                        let h = CGFloat((self.tableHeight * self.currentRoundAry.count))
                        self.tblHeight.constant = h
                        self.viewHeight.constant = 0
                        self.pridictionView.isHidden = true
                    }else {
                        self.tblHeight.constant = CGFloat((self.tableHeight * self.currentRoundAry.count) + (self.currentRoundAry.count * 20))
                        self.pridictionView.addBottomShadow()
                        self.viewHeight.constant = 215
                        self.pridictionView.isHidden = false
                    }
                    //print( self.currentRoundAry.count)
                    self.homeTBL.isHidden = false
                    self.homeTBL.reloadData()
                    //print(self.playData)
                } catch {
                    self.view.makeToast("Can not read data")
                }
            }else{
                print(error?.localizedDescription as Any)
            }
        }
    }
}
