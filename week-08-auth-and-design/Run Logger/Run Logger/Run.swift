//
//  Run.swift
//  Run Logger
//
//  Created by Isaac Sheets on 3/4/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import Foundation

struct Run {
    var title : String
    var date : Date
    var miles : Double
    var duration : TimeInterval
    var notes : String
    
    func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    func getPace() -> String {
        let minutes = duration / 60
        let pace = minutes / miles
        let rounded = (pace*100).rounded()/100
        let decimal = rounded.truncatingRemainder(dividingBy: 1)
        
        return "\(String(format: "%.0f", rounded)):\(String(format: "%.0f", (decimal*60).rounded()))"
    }
    
    func getTime() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        formatter.maximumUnitCount = 3

        return formatter.string(from: duration)!
    }
    
}
