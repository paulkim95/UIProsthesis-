//
//  ViewController.swift
//  UI_Prosthesis
//
//  Created by Paul Kim on 10/2/16.
//  Copyright © 2016 Paul Kim. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate, WCSessionDelegate {

    @IBOutlet var gripPicker: UIPickerView!
    
    @IBOutlet var watchData: UILabel!
    
    
    var session:WCSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        gripManager.initGrips()
        setupWCSession()
       
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    //MARK: picker view
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (gripManager.grips?.count)!
        
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let g = gripManager.grips![row]
        return g.name
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    //func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //selecedGRip = gripmanager
   // }
}

extension ViewController{
    
    func setupWCSession(){
        session = WCSession.defaultSession()
        session.delegate = self
        session.activateSession()
    }
    
    enum sendDataType {
        case applicationContext
        case userInfo
        case messaging
    }
    func sendData(sendtype:sendDataType){
        if session.paired == true {
            print("paired with watch")
            switch sendtype{
            case .applicationContext: sendApplicationContext()
            case .userInfo: sendUserInfo()
            case .messaging: sendMessage()
                
            }
            
            sendApplicationContext()
           
        }
        else{
            print("Not paired to watch")
        }

    }
    
    //MARK: applicationContext
    
    func sendApplicationContext(){
        do{
            let context = ["mykey":"testing from iPhone"]
            try WCSession.defaultSession().updateApplicationContext(context)
            print("sent data from iPhone to Watch")
            
        }
        catch{
            print("error occurred")
        }
        
    }
    
    @IBAction func sendDataButton_click(sender: AnyObject) {
        sendData(.userInfo)
        
    }
    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        let data = applicationContext["my key"] as! String
        watchData.text = data
        print("applicationContext from Watch \(applicationContext)")
    }

    //MARK: userInfo
    func sendUserInfo(){
          print("start of userInfo send fron iPhone")
        let userInfo = ["uikey":"userInfo from iPhone"]
        let userInfoTransfer = WCSession.defaultSession().transferUserInfo(userInfo)
        print("user info transferred.\(userInfoTransfer)")
        let transfers = WCSession.defaultSession().outstandingUserInfoTransfers
        print("user info transfers: \(transfers)")
        
    }
    func session(session: WCSession, didReceiveUserInfo userInfo: [String : AnyObject]) {
        print("userinfo received at iPhone: \(userInfo)")
        
    }
    //MARK: messaging
    func sendMessage(){
        if WCSession.defaultSession().reachable{
            WCSession.defaultSession().sendMessage(["mkey":"phone message"], replyHandler: { (_: [String : AnyObject]) in
                print("reply from watch on messaging")
                }, errorHandler: { (NSError) in
                    print("error occurred on phone in messaging")
            })
        }
        
    }
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
        print("message received from watch")
        self.watchData.text = message["mkey"] as? String
    }

}


