//
//  DeviceChecker.swift
//  DeviceChecker
//
//  Created by KraferdMBP31 on 6/24/16.
//  Copyright © 2016 Kraferd. All rights reserved.
//

import Foundation
import Alamofire

public class DeviceChecker {
    let url : NSURL;
    
    let deviceID : String;
    
    let appID : String;
    
    //let application : UIApplication;
    
    let initialBatteryState : UIDeviceBatteryState;
    
    var mainTimer : NSTimer;
    
    init(url: NSURL, appID: String, testing: Bool) {
        self.url = url;
        
        self.appID = appID;
        //self.application = application;
        
        self.initialBatteryState = UIDevice.currentDevice().batteryState;
        
        self.deviceID = UIDevice.currentDevice().identifierForVendor!.UUIDString;
        
        self.mainTimer = NSTimer();
        
        self.mainTimer = NSTimer(timeInterval: 10.0, target: self, selector: #selector(self.mainTask(_:)), userInfo: nil, repeats: true);
        if !testing {
            NSRunLoop.mainRunLoop().addTimer(self.mainTimer, forMode: NSRunLoopCommonModes);
        }
    }
    
    @objc func mainTask(sender: AnyObject?) {
        self.sendRequest({() -> Void in
            
        });
    }
    
    func sendRequest(completion: (() -> Void)) {
        let dataToBeSent : [String : AnyObject] = ["app-id" : self.appID,
                                                "device-id" : self.deviceID,
                                                "battery-state" : self.initialBatteryState.rawValue];
        
        request(.POST, url, parameters: dataToBeSent, encoding: .JSON).response {(response) in
            print(response)
            completion();
        };
    }
}

public func createChecker(url: NSURL, appID: String) -> DeviceChecker {
    return DeviceChecker(url: url, appID: appID, testing: false);
}
