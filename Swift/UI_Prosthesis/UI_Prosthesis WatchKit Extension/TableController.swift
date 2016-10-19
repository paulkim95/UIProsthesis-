//
//  TableController.swift
//  UI_Prosthesis
//
//  Created by Paul Kim on 10/2/16.
//  Copyright © 2016 Paul Kim. All rights reserved.
//

import WatchKit
import Foundation


class TableController: WKInterfaceController {

    
    //let gripList = ["Platform", "Point", "Hook", "Lateral Pinch", "Tip", " Tripod", "Close", "Spherial", "Cylindrical"]
   
    
    @IBOutlet var tableview: WKInterfaceTable!
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        loadTable()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    func loadTable() {
        tableview.setNumberOfRows(gripManager.grips!.count, withRowType: "rowController")
        var i = 0
        for g in gripManager.grips!{
            let row = tableview.rowControllerAtIndex(i) as! tableRow
            row.rowLabel.setText(g.name)
            i = i + 1
            
        }
    }
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        let selectedItem = gripManager.grips![rowIndex]
        print(selectedItem)
        
    }
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
        return gripManager.grips![rowIndex]
    }
}
