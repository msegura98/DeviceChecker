//
//  DeviceChecker.swift
//  DeviceChecker
//
//  Created by KraferdMBP31 on 6/24/16.
//  Copyright © 2016 Kraferd. All rights reserved.
//

import Foundation

class DeviceChecker {
    let url : NSURL = NSURL(string: "https://www.example.org/")!;
    
    let deviceID : String;
    
    let appID : String;
    
    //let application : UIApplication;
    
    let initialBatteryState : UIDeviceBatteryState;
    
    var mainTimer : NSTimer;
    
    var count : Int = 0;
    
    init(url: NSURL, deviceID: String, appID: String) {
        //self.url = url;
        self.deviceID = deviceID;
        
        print("\(UIDevice.currentDevice().identifierForVendor!.UUIDString)")
        
        self.appID = appID;
        //self.application = application;
        
        self.initialBatteryState = UIDevice.currentDevice().batteryState;
        
        self.mainTimer = NSTimer();
        
        self.mainTimer = NSTimer(timeInterval: 1.0, target: self, selector: #selector(self.mainTask(_:)), userInfo: nil, repeats: true);
        
        NSRunLoop.mainRunLoop().addTimer(self.mainTimer, forMode: NSRunLoopCommonModes);
    }
    
    @objc func mainTask(sender: AnyObject?) {
        let session = NSURLSession.sharedSession();
        let request = NSMutableURLRequest(URL: self.url);
        
        request.HTTPMethod = "POST"
        request.cachePolicy = .ReloadIgnoringLocalAndRemoteCacheData;
        
        let dataToBeSent : [String : String] = ["app-id" : self.appID,
                                                "device-id" : self.deviceID]
        
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(dataToBeSent, options: .PrettyPrinted);
            
            request.HTTPBody = jsonData;
            
            let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
                print("Request Completed \(self.count)");
                print("Request Data: \(data)")
                print("Request Response: \(response)");
                print("Request error: \(error)");
                self.count = self.count + 1;
            });
            
            task.resume();
        } catch {
            print("Error \(error)");
            return;
        }
    }
}
