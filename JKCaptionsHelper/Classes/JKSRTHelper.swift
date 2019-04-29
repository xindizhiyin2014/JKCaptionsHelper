//
//  JKSRTHelper.swift
//  JKCaptionsHelper
//
//  Created by JackLee on 2019/4/29.
//

import Foundation
enum JKSubTitleType {
    case oneLanguage          // 单语言字幕模式
    case twoLanguage          // 双语言字幕模式
}

class JKSRTHelper :NSObject {
    
    private var beginTimes:[Float]?         // 字幕开始时间
    private var endTimes:[Float]?           // 字幕结束时间
    private var firstSubTitles:[String]?    // 第一语言字幕
    private var secondSubTitles:[String]?   // 第二语言字幕
    private var progressIndex = 0           // 字幕播放进度索引
    
    
    class public func initWithFilePath(filePath:NSString!,subTitleType:JKSubTitleType!) -> JKSRTHelper{
        let data = NSData.init(contentsOfFile: filePath as String)
       return self.initWithData(data: data,subTitleType: subTitleType)
    }
    
    class public func initWithString(content:String!,subTitleType:JKSubTitleType!) ->JKSRTHelper{
        let data = content.data(using: .utf8, allowLossyConversion: true)
        return self.initWithData(data: data as NSData?,subTitleType: subTitleType)
    }
    
    class public func initWithData(data:NSData?,subTitleType:JKSubTitleType!) -> JKSRTHelper{
        let content = String(data: data! as Data, encoding: .utf8)
        let array = content?.components(separatedBy: "\n")
        var beginTimes = [Float]()
        var endTimes = [Float]()
        var firstSubTitles = [String]()
        var secondSubTitles:[String]?

        var unitLineCount = 4    //单位行数
        if subTitleType == .twoLanguage{
            unitLineCount = 5
            secondSubTitles = [String]()
        }
    
        for i in 0 ..< array!.count {
            
            if i%unitLineCount == 0 {   //不做处理
              
            }
            else if i%unitLineCount == 1 { //时间处理
                let timeStr = array![i]
                let range:Range = timeStr.range(of: " --> ")!
                if range.isEmpty == false {
                    let beginStr = String(timeStr[..<range.lowerBound])
                    let endStr = String(timeStr[range.upperBound...])
                    let arr1 = beginStr.components(separatedBy:":")
                    let arr2 = arr1[2].components(separatedBy:",")
                    //将开始时间数组中的时间转换为秒为单位的
                    let beginHour:Float = Float(arr1[0])! * Float(60) * Float(60)
                    let beginMinute:Float = Float(arr1[1])! * Float(60)
                    let beginSecond:Float = Float(arr2[0])! + Float(arr2[1])!/Float(1000)
                    let beginTime = beginHour + beginMinute + beginSecond
                    beginTimes.append(beginTime)

                    let arr3 = endStr.components(separatedBy: ":")
                    let arr4 = arr3[2].components(separatedBy: ",")
                    //将结束时间数组中的时间转换为秒为单位的
                    let endHour:Float = Float(arr3[0])! * Float(60) * Float(60)
                    let endMinute:Float = Float(arr3[1])! * Float(60)
                    let endSecond:Float = Float(arr4[0])! + Float(arr4[1])!/Float(1000)
                    let endTime = endHour + endMinute + endSecond
                    endTimes.append(endTime)
                    
                }
                
            }
            else{
                
                if i%unitLineCount == 2 {  //第一语言字幕
                    firstSubTitles.append(array![i])
                }
                else if i%unitLineCount == 3{ //第二语言字幕
                   secondSubTitles!.append(array![i])
                }
                
            }
            
        }
        let srtHelper:JKSRTHelper = JKSRTHelper.init()
        srtHelper.beginTimes = beginTimes
        srtHelper.endTimes = endTimes
        srtHelper.firstSubTitles = firstSubTitles
        srtHelper.secondSubTitles = secondSubTitles
        return srtHelper
    
    }
    
    class public func initWithArray(array:[NSDictionary]) -> JKSRTHelper{
        var beginTimes = [Float]()
        var endTimes = [Float]()
        var firstSubTitles = [String]()
        
        for dic:NSDictionary in array {
            let timeStr:String = dic["duration"] as! String
            let lines:String = dic["lines"] as! String
            firstSubTitles.append(lines)
            
            let range:Range = timeStr.range(of: " --> ")!
            if range.isEmpty == false {
                let beginStr = String(timeStr[..<range.lowerBound])
                let endStr = String(timeStr[range.upperBound...])
                let arr1 = beginStr.components(separatedBy:":")
                let arr2 = arr1[2].components(separatedBy:",")
                //将开始时间数组中的时间转换为秒为单位的
                let beginHour:Float = Float(arr1[0])! * Float(60) * Float(60)
                let beginMinute:Float = Float(arr1[1])! * Float(60)
                let beginSecond:Float = Float(arr2[0])! + Float(arr2[1])!/Float(1000)
                let beginTime = beginHour + beginMinute + beginSecond
                beginTimes.append(beginTime)
                
                let arr3 = endStr.components(separatedBy: ":")
                let arr4 = arr3[2].components(separatedBy: ",")
                //将结束时间数组中的时间转换为秒为单位的
                let endHour:Float = Float(arr3[0])! * Float(60) * Float(60)
                let endMinute:Float = Float(arr3[1])! * Float(60)
                let endSecond:Float = Float(arr4[0])! + Float(arr4[1])!/Float(1000)
                let endTime = endHour + endMinute + endSecond
                endTimes.append(endTime)
                
            }
        }
        
        let srtHelper:JKSRTHelper = JKSRTHelper.init()
        srtHelper.beginTimes = beginTimes
        srtHelper.endTimes = endTimes
        srtHelper.firstSubTitles = firstSubTitles
        return srtHelper
    }
    
    public func playSRTWithTime(currentTime:CGFloat,content:((_ firstSubTitle:String?,_ secondSubTitle:String?)->Void)!) -> Void {
        let time:Float = Float(currentTime)
        for i in self.progressIndex ..< self.beginTimes!.count {
            let beiginTime = self.beginTimes![i]
            let endTime = self.endTimes![i]
            if time >= beiginTime && time <= endTime {
                if let content = content {
                    let firstSubTitle = self.firstSubTitles![i]
                    let secondSubTitle = self.secondSubTitles![i]
                    
                    content(firstSubTitle,secondSubTitle)
                }
                self.progressIndex = i
                break
            }
            
        }
    }
    
    public func resetProgressIndex() -> Void{
        self.progressIndex = 0
    }
    
    
}
