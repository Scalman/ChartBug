//
//  ChartModel.swift
//  Dashboard
//
//  Created by Gustaf Holmström on 2018-04-15.
//  Copyright © 2018 Waleed Hassan. All rights reserved.
//

import Foundation
import UIKit
import Charts

class ChartModel {
    
    public func generateTestDat() -> [WorkDay]{
        
        
        var weekDays = [Week]()
        weekDays.append(Week.monday)
        weekDays.append(Week.tuesday)
        weekDays.append(Week.wednsday)
        weekDays.append(Week.thursday)
        weekDays.append(Week.friday)
        weekDays.append(Week.saturday)
        weekDays.append(Week.sunday)
        
        var workWeek = [WorkDay]()
        
        for day in weekDays {
            let shifts = randomShifts()
            workWeek.append(WorkDay(WeekDay: day, date: Date(), shifts: shifts))
        }
        
        return workWeek
        
    }
    private func randomShifts() -> [Shift]{

        var shifts = [Shift]()
        
        var count = 8
        
        var startTime = 10
        
        while count > 0 {
            let hour = Double((arc4random_uniform(UInt32(count))) + 1)
            count = count - Int(hour)
            
            var startDate = DateComponents()
            startDate.year = 2018
            startDate.month = 9
            startDate.day = 30
            startDate.hour = startTime
            let shiftStart = Calendar.current.date(from: startDate)
            
            var endDate = DateComponents()
            endDate.year = 2018
            endDate.month = 9
            endDate.day = 30
            endDate.hour = Int(startTime + Int(hour))
            let shiftEnd = Calendar.current.date(from: endDate)
            
            startTime += Int(hour)
            
            
            let newShift = Shift.init(startTime: shiftStart, endTime: shiftEnd, description: "Desc", colour: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), hours: hour)
            shifts.append(newShift)
        }
        
        return shifts
    }
}

enum Week {
    case monday
    case tuesday
    case wednsday
    case thursday
    case friday
    case saturday
    case sunday
}

struct WorkDay {
    var WeekDay:Week?
    var date:Date?
    var elapsedWorkTime: Double {
        var count = 0.0
        for shift in shifts! {
            count += shift.hours!
        }
        return count
    }
    
    var shifts:[Shift]?
}

struct Shift {
    var startTime:Date?
    var endTime:Date?
    var description:String?
    var colour:UIColor?
    var hours:Double?
    func funktion() -> TimeInterval{
        return (startTime?.timeIntervalSince(endTime!))!
    }
}


