//
//  PLEventManger.swift
//  PLEventCalendar
//
//  Created by 彭磊 on 2020/9/7.
//

import UIKit
import EventKit

public class PLEventManger: NSObject {
    public static let shared = PLEventManger()
    /// 开启日历提醒
    public func openCalendarReminder(remindCount: Int) {
        eventArrs.removeAll()
        let residueCount = 7 - remindCount
        for i in 1..<residueCount {
            createCalendarTitle(title: "叮～你今日份的潮流任务奖励待领取！", startDate: getTomorrowDate(12, dayCount: i), endDate: getTomorrowDate(13, dayCount: i), allDay: false, alarmArray: ["-60"])
        }
    }
    
    /// 关闭日历提醒
    public func closeCalendarReminder() {
        removeEventCalendar()
    }
    
    /// 将APP事件添加到系统日历提醒事项中，实现闹铃提醒的功能
     public func createCalendarTitle(title: String, startDate: Date, endDate: Date, allDay: Bool, alarmArray: Array<String>) {
            EventCalendar.eventStore.requestAccess(to: EKEntityType.event) { [weak self] (granted, error) in
                DispatchQueue.main.async {
                    //用户没授权
                    if !granted {
                        let alertViewController = UIAlertController(title: "提示", message: "请在iPhone的\"设置->隐私->日历\"选项中,允许得物访问你的日历。", preferredStyle: .alert)
                        let actionCancel = UIAlertAction(title: "取消", style: .cancel, handler: { (action) in
                        })
                        let actinSure = UIAlertAction(title: "设置", style: .default, handler: { (action) in
                            //跳转到系统设置主页
                            if let url = URL(string: UIApplication.openSettingsURLString) {
                                //根据iOS系统版本，分别处理
                                if #available(iOS 10, *) {
                                    UIApplication.shared.open(url)
                                } else {
                                    UIApplication.shared.openURL(url)
                                }
                            }
                        })
                        alertViewController.addAction(actionCancel)
                        alertViewController.addAction(actinSure)
                        // FIXME: - 弹出这个alertViewController
                        return
                    }
                    //允许
                    if granted {
                        //过滤重复事件
                        let predicate = EventCalendar.eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)  //根据时间段来筛选
                        let eventsArray = EventCalendar.eventStore.events(matching: predicate)
                        if eventsArray.count > 0 {
                            for item in eventsArray {
                                //根据事件唯一性,如果已经插入的就不再插入了
                                if let start = item.startDate, let end = item.endDate {
                                    if start == startDate && end == endDate {
                                        return
                                    }
                                }
                            }
                        }
                        
                        let event = EKEvent(eventStore: EventCalendar.eventStore)
                        event.title = title
                        event.startDate = startDate
                        event.endDate = endDate
                        event.isAllDay = allDay
                        
                        //添加提醒时间(提前)
                        if alarmArray.count > 0 {
                            for timeString in alarmArray {
                                if let time = TimeInterval(timeString) {
                                    event.addAlarm(EKAlarm(relativeOffset: TimeInterval(time)))
                                }
                            }
                        }
                        
                        event.calendar = EventCalendar.eventStore.defaultCalendarForNewEvents  //必须设置系统的日历
                        do {
                            try EventCalendar.eventStore.save(event, span: EKSpan.thisEvent)
                        }catch{}
                        
                        print("事件ID--\(event.eventIdentifier)")  //(只读)系统随机生成的,需要保存下来,下次删除使用
                        self?.eventId = event.eventIdentifier  //保存本次事件id   可以通过后台返回的id做这次保存的key值,偏好设置保存
                        if let eventId = self?.eventId {
                            self?.eventArrs.append(eventId)
                            print("成功添加到系统日历中")
                        }
                        UserDefaults.standard.set(true, forKey: "userTaskCalendarStatus")
                    }
                }
            }
        }
        
        var eventId: String?
        var eventArrs: [String] = []
        ///删除指定事件 根据事件id来删除
        public func removeEventCalendar() {
            for item in eventArrs {
                guard let event = EventCalendar.eventStore.event(withIdentifier: item) else {
                    return
                }
                do {
                    try EventCalendar.eventStore.remove(event, span: EKSpan.thisEvent)
                } catch {}
                print("删除成功")
            }
            UserDefaults.standard.set(false, forKey: "userTaskCalendarStatus")
        }
        
        ///删除某个时间段所有的事件(会删除这个时间段所有时间,包括用户自己添加的)
        public func removeAllEventCalendar(startDate: Date, endDate: Date) {
            let predicate = EventCalendar.eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)  //根据时间段来筛选
            let eventsArray = EventCalendar.eventStore.events(matching: predicate)
            if eventsArray.count > 0 {
                for item in eventsArray {
                    //删除老版本插入的提醒
                    do {
                        try EventCalendar.eventStore.remove(item, span: EKSpan.thisEvent, commit: true)
                    }catch{}
                    print("删除过期时间成功")
                }
            }
        }
        
    /// 获取第二天中午12点的Date
        public func getTomorrowDate(_ timeCount: Int, dayCount: Int) -> Date {
            let calendar = NSCalendar.current
            var componts = calendar.dateComponents([.weekday, .year, .month, .day], from: Date())
            guard let day = componts.day else {
                return Date()
            }
            componts.day = day + dayCount
            let tomorrowInterval: TimeInterval = TimeInterval((calendar.date(from: componts)?.timeIntervalSince1970 ?? 0) + TimeInterval(timeCount * 60 * 60))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let tomorrowDate = Date(timeIntervalSince1970: tomorrowInterval)
            return tomorrowDate
        }
}
