//
//  EventCalendar.swift
//  PLEventCalendar
//
//  Created by 彭磊 on 2020/9/7.
//

import UIKit
import EventKit

public class EventCalendar: NSObject {
    //单例
    static let eventStore = EKEventStore()
    
    ///用户是否授权使用日历
    func isEventStatus() -> Bool {
        let eventStatus = EKEventStore.authorizationStatus(for: EKEntityType.event)
        if eventStatus == .denied || eventStatus == .restricted {
            return false
        }
        return true
    }
}
