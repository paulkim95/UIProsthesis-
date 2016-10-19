//
//  InterfaceController.swift
//  UI_Prosthesis WatchKit Extension
//
//  Created by Paul Kim on 10/2/16.
//  Copyright © 2016 Paul Kim. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    @IBOutlet var dataCheck: WKInterfaceLabel!
    //@IBOutlet var gripName: WKInterfaceLabel!
    @IBOutlet var gripPicker: WKInterfacePicker!
    var session: WCSession!
    
    
   // let gripList = ["Platform", "Point", "Hook", "Lateral Pinch", "Tip", " Tripod", "Close", "Spherial", "Cylindrical"]
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        
        // Configure interface objects here.
        
        loadGrips()
        setupWCSession()
        
      
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
       
    }

    func loadGrips (){
        gripManager.initGrips()
        var pickerItems:[WKPickerItem] = [WKPickerItem]()
        
        var i = 1
        for g in gripManager.grips!{
            let item = WKPickerItem()
            item.title = g.name
            item.contentImage = WKImage(imageName: g.image!)
            item.caption = g.name
           // item.
            
            pickerItems.append(item)
            i = i + 1
            
            
    }
    gripPicker.setItems(pickerItems)
}
    
    
    //@IBAction func pickerChanged(value: Int) {
      //  let g = gripManager.grips![]
      //  gripName.setText(g.name)
   // }
   
    
    
    // notification
    override func handleActionWithIdentifier(identifier: String?, forRemoteNotification remoteNotification: [NSObject : AnyObject]) {
        let data = remoteNotification["mykey"] as? String
        print(data)
    }
    
}

extension InterfaceController{
    func setupWCSession(){
        //create session
        
        if WCSession.isSupported(){
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
            
            print("Watch WCSession activated")
        }
        
    }
    //MARK: applicaitonContext
    
    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        print("applicationContext on watch \(applicationContext)")
        let mystring = applicationContext["mykey"] as! String
        print(mystring)
    }
    
    @IBAction func sendDataButton_click() {
        
       /* let context = ["uikey":"testing userInfo from watch"]
        WCSession.defaultSession().transferUserInfo(context)
        print("userInfo sent to iPhone")
       */
        /*do{
            let context = ["my key":"testing from watch"]
            try WCSession.defaultSession().updateApplicationContext(context)
           
            print("data sent to iPhone")
            
        }
        catch{
            print("error occurred on watch applicationContext send")
            
        }*/
        //messaging
        if(WCSession.defaultSession().reachable){
            session.sendMessage(["mkey":"from watch"], replyHandler: nil, errorHandler: nil)
            print("sent message to iPhone")
            
            
        }
        
    }
    
    //MARK: userInfo
    func session(session: WCSession, didReceiveUserInfo userInfo: [String : AnyObject]) {
      
        let context = userInfo["uikey"]
        print("userInfo received at watch: \(context)")
    }
    
    //MARK: messaging
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        print("message received from iPhone")
        dataCheck.setText(message["mkey"] as? String)
        
        
    }
}
