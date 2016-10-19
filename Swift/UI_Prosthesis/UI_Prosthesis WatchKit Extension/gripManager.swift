//
//  gripManager.swift
//  UI_Prosthesis
//
//  Created by Paul Kim on 10/2/16.
//  Copyright © 2016 Paul Kim. All rights reserved.
//

import WatchKit

class gripManager: NSObject {
    static var grips: [grip]?
    
    static func initGrips(){
        let g1 = grip()
        g1.name = "Palm down "
        g1.image = "palm_down"
        g1.number = "1"
        
        let g2 = grip()
        g2.name = "Palm up"
        g2.image = "palm_up"
        g2.number = "2"
        
        let g3 = grip()
        g3.name = "Key grip"
        g3.image = "key_grip"
        g3.number = "3"
        
        let g4 = grip()
        g4.name = "Tripod grip"
        g4.image = "tripod_grip"
        g4.number = "4"
        
        let g5 = grip()
        g5.name = "Thumb oppose"
        g5.image = "thumb_oppose"
        g5.number = "5"
        
        let g6 = grip()
        g6.name = "Index point"
        g6.image = "index_point"
        g6.number = "6"
        
        let g7 = grip()
        g7.name = "Hand close"
        g7.image = "hand_close"
        g7.number = "7"
        
        let g8 = grip()
        g8.name = "Hand open"
        g8.image = "hand_open"
        g8.number = "8"
        
        //let g9 = grip()
        //g9.name = "Cylindrical"
        //g9.image = "nine"
        //g9.number = "9"
        
        self.grips = []
        self.grips?.append(g1)
        self.grips?.append(g2)
        self.grips?.append(g3)
        self.grips?.append(g4)
        self.grips?.append(g5)
        self.grips?.append(g6)
        self.grips?.append(g7)
        self.grips?.append(g8)
        //self.grips?.append(g9)
        
        
        
    }
    
}
