//
//  DeviceChecker.swift
//  DeviceChecker
//
//  Created by KraferdMBP31 on 6/24/16.
//  Copyright © 2016 Kraferd. All rights reserved.
//

import Foundation

public class DeviceChecker {
    let url : NSURL = NSURL(string: "https://www.example.org/")!;
    
    let deviceID : String;
    
    let appID : String;
    
    //let application : UIApplication;
    
    let initialBatteryState : UIDeviceBatteryState;
    
    var mainTimer : NSTimer;
    
    init(url: NSURL, deviceID: String, appID: String, testing: Bool) {
        //self.url = url;
        self.deviceID = deviceID;
        
        self.appID = appID;
        //self.application = application;
        
        self.initialBatteryState = UIDevice.currentDevice().batteryState;
        
        self.mainTimer = NSTimer();
        
        self.mainTimer = NSTimer(timeInterval: 10.0, target: self, selector: #selector(self.mainTask(_:)), userInfo: nil, repeats: true);
        if !testing {
            NSRunLoop.mainRunLoop().addTimer(self.mainTimer, forMode: NSRunLoopCommonModes);
        }
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
            
            let jsonString = String(data: jsonData, encoding: NSASCIIStringEncoding)!
            
            request.HTTPBody = jsonString.dataUsingEncoding(NSUTF8StringEncoding);
            
            let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
                print("Request Completed");
                print("Request Data: \(data)")
                print("Request Response: \(response)");
                print("Request error: \(error)");
            });
            
            task.resume();
        } catch {
            print("Error \(error)");
            return;
        }
    }
}

public func createChecker(url: NSURL, deviceID: String, appID: String) -> DeviceChecker {
    return DeviceChecker(url: url, deviceID: deviceID, appID: appID, testing: false);
}
