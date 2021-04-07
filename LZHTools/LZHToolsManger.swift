//
//  LZHToolsManger.swift
//  LZHToolsDemo
//
//  Created by QD202010282474A on 2021/4/2.
//

import UIKit

class LZHToolsManger: NSObject {
    override init() {
        super.init()
    }

    func say() {
        print("12312312321")
    }

}
extension Date {
    // 获取当前 秒级 时间戳 - 10位
    public  var SecondTimeStamp : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return "\(timeStamp)"
    }


    // 获取当前 毫秒级 时间戳 - 13位
    public  var MillisecondTimestamps : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return "\(millisecond)"
    }


    /*格式化时间格式 转时间戳字符串
     "''" => "\\'",  // two single quotes produce one
     'G' => '',      // era designator like (Anno Domini)
     'Y' => 'o',     // 4digit year of "Week of Year"
     'y' => 'Y',     // 4digit year e.g. 2014
     'yyyy' => 'Y',  // 4digit year e.g. 2014
     'yy' => 'y',    // 2digit year number eg. 14
     'u' => '',      // extended year e.g. 4601
     'U' => '',      // cyclic year name, as in Chinese lunar calendar
     'r' => '',      // related Gregorian year e.g. 1996
     'Q' => '',      // number of quarter
     'QQ' => '',     // number of quarter '02'
     'QQQ' => '',    // quarter 'Q2'
     'QQQQ' => '',   // quarter '2nd quarter'
     'QQQQQ' => '',  // number of quarter '2'
     'q' => '',      // number of Stand Alone quarter
     'qq' => '',     // number of Stand Alone quarter '02'
     'qqq' => '',    // Stand Alone quarter 'Q2'
     'qqqq' => '',   // Stand Alone quarter '2nd quarter'
     'qqqqq' => '',  // number of Stand Alone quarter '2'
     'M' => 'n',     // Numeric representation of a month, without leading zeros
     'MM' => 'm',    // Numeric representation of a month, with leading zeros
     'MMM' => 'M',   // A short textual representation of a month, three letters
     'MMMM' => 'F',  // A full textual representation of a month, such as January or March
     'MMMMM' => '',
     'L' => 'n',     // Stand alone month in year
     'LL' => 'm',    // Stand alone month in year
     'LLL' => 'M',   // Stand alone month in year
     'LLLL' => 'F',  // Stand alone month in year
     'LLLLL' => '',  // Stand alone month in year
     'w' => 'W',     // ISO-8601 week number of year
     'ww' => 'W',    // ISO-8601 week number of year
     'W' => '',      // week of the current month
     'd' => 'j',     // day without leading zeros
     'dd' => 'd',    // day with leading zeros
     'D' => 'z',     // day of the year 0 to 365
     'F' => '',      // Day of Week in Month. eg. 2nd Wednesday in July
     'g' => '',      // Modified Julian day. This is different from the conventional Julian day number in two regards.
     'E' => 'D',     // day of week written in short form eg. Sun
     'EE' => 'D',
     'EEE' => 'D',
     'EEEE' => 'l',  // day of week fully written eg. Sunday
     'EEEEE' => '',
     'EEEEEE' => '',
     'e' => 'N',     // ISO-8601 numeric representation of the day of the week 1=Mon to 7=Sun
     'ee' => 'N',    // php 'w' 0=Sun to 6=Sat isn't supported by ICU -> 'w' means week number of year
     'eee' => 'D',
     'eeee' => 'l',
     'eeeee' => '',
     'eeeeee' => '',
     'c' => 'N',     // ISO-8601 numeric representation of the day of the week 1=Mon to 7=Sun
     'cc' => 'N',    // php 'w' 0=Sun to 6=Sat isn't supported by ICU -> 'w' means week number of year
     'ccc' => 'D',
     'cccc' => 'l',
     'ccccc' => '',
     'cccccc' => '',
     'a' => 'A',     // AM/PM marker
     'h' => 'g',     // 12-hour format of an hour without leading zeros 1 to 12h
     'hh' => 'h',    // 12-hour format of an hour with leading zeros, 01 to 12 h
     'H' => 'G',     // 24-hour format of an hour without leading zeros 0 to 23h
     'HH' => 'H',    // 24-hour format of an hour with leading zeros, 00 to 23 h
     'k' => '',      // hour in day (1~24)
     'kk' => '',     // hour in day (1~24)
     'K' => '',      // hour in am/pm (0~11)
     'KK' => '',     // hour in am/pm (0~11)
     'm' => 'i',     // Minutes without leading zeros, not supported by php but we fallback
     'mm' => 'i',    // Minutes with leading zeros
     's' => 's',     // Seconds, without leading zeros, not supported by php but we fallback
     'ss' => 's',    // Seconds, with leading zeros
     'S' => '',      // fractional second
     'SS' => '',     // fractional second
     'SSS' => '',    // fractional second
     'SSSS' => '',   // fractional second
     'A' => '',      // milliseconds in day
     'z' => 'T',     // Timezone abbreviation
     'zz' => 'T',    // Timezone abbreviation
     'zzz' => 'T',   // Timezone abbreviation
     'zzzz' => 'T',  // Timezone full name, not supported by php but we fallback
     'Z' => 'O',     // Difference to Greenwich time (GMT) in hours
     'ZZ' => 'O',    // Difference to Greenwich time (GMT) in hours
     'ZZZ' => 'O',   // Difference to Greenwich time (GMT) in hours
     'ZZZZ' => '\G\M\TP', // Time Zone: long localized GMT (=OOOO) e.g. GMT-08:00
     'ZZZZZ' => '',  //  TIme Zone: ISO8601 extended hms? (=XXXXX)
     'O' => '',      // Time Zone: short localized GMT e.g. GMT-8
     'OOOO' => '\G\M\TP', //  Time Zone: long localized GMT (=ZZZZ) e.g. GMT-08:00
     'v' => '\G\M\TP', // Time Zone: generic non-location (falls back first to VVVV and then to OOOO) using the ICU defined fallback here
     'vvvv' => '\G\M\TP', // Time Zone: generic non-location (falls back first to VVVV and then to OOOO) using the ICU defined fallback here
     'V' => '',      // Time Zone: short time zone ID
     'VV' => 'e',    // Time Zone: long time zone ID
     'VVV' => '',    // Time Zone: time zone exemplar city
     'VVVV' => '\G\M\TP', // Time Zone: generic location (falls back to OOOO) using the ICU defined fallback here
     'X' => '',      // Time Zone: ISO8601 basic hm?, with Z for 0, e.g. -08, +0530, Z
     'XX' => 'O, \Z', // Time Zone: ISO8601 basic hm, with Z, e.g. -0800, Z
     'XXX' => 'P, \Z',    // Time Zone: ISO8601 extended hm, with Z, e.g. -08:00, Z
     'XXXX' => '',   // Time Zone: ISO8601 basic hms?, with Z, e.g. -0800, -075258, Z
     'XXXXX' => '',  // Time Zone: ISO8601 extended hms?, with Z, e.g. -08:00, -07:52:58, Z
     'x' => '',      // Time Zone: ISO8601 basic hm?, without Z for 0, e.g. -08, +0530
     'xx' => 'O',    // Time Zone: ISO8601 basic hm, without Z, e.g. -0800
     'xxx' => 'P',   // Time Zone: ISO8601 extended hm, without Z, e.g. -08:00
     'xxxx' => '',   // Time Zone: ISO8601 basic hms?, without Z, e.g. -0800, -075258
     'xxxxx' => '',  // Time Zone: ISO8601 extended hms?, without Z, e.g. -08:00, -07:52:58
     *
     */
    public func dateStringToTimeStampStr(stringTime:String,dateFormatter:String = "yyyy-MM-dd HH:mm")-> String {

        let dfmatter = DateFormatter()

        dfmatter.dateFormat = dateFormatter

        let date = dfmatter.date(from: stringTime)

        let dateStamp:TimeInterval = date!.timeIntervalSince1970

        let dateSt:Int = Int(dateStamp)

        return String(dateSt)

    }


    /*
     *  date 转 格式化后的时间字符串
     */
    public func dateToString(date:Date, dateFormatter:String = "yyyy-MM-dd HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormatter
        return formatter.string(for: date)!
    }

}


extension String{

    public func md5(strs:String) ->String!{
        let str = strs.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(strs.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(16)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize(count: 0)
        return String(format: hash as String)
    }

    public func base64Encoding(str:String)->String

    {
        let strData = str.data(using: String.Encoding.utf8)
        let base64String = strData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))

        return base64String!
    }

    public  func getDictionaryFromJSONString(jsonString:String) ->Dictionary<String, Any>{

        let jsonData:Data = jsonString.data(using: .utf8)!

        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! Dictionary<String, Any>
        }
        return NSDictionary() as! Dictionary<String, Any>


    }

    //MARK: 获得字符串的尺寸
    public  func needTextRect(font: UIFont) -> CGRect {
        return self.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 0), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    }
    //将原始的url编码为合法的url
    public func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }

    //将编码后的url转换回原始的url
    public func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }

}


