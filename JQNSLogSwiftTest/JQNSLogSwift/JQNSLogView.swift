//
//  JQNSLogView.swift
//  JQNSLogSwiftTest
//
//  Created by zhongkang on 2020/3/24.
//  Copyright © 2020 zhongkang. All rights reserved.
//

import UIKit





class JQNSLogView: UIView {
    
    //允许移动
    var isMove = true

    //日志view
    var logView = UIView()

    //显示日志view
    var textView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let toViewBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        self .addSubview(toViewBtn)
        toViewBtn.backgroundColor = UIColor.red
        toViewBtn.alpha = 0.5;
        toViewBtn .setTitle("查看日志", for: .normal)
        toViewBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        toViewBtn .addTarget(self, action: #selector(setUpdateWorkLog), for: .touchUpInside)
         
    }
    
    //设置打印日志
    @objc func setUpdateWorkLog() {
        isMove = false
        self.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
         logView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        self.addSubview(logView)
        
        textView = UITextView(frame: CGRect(x: 0, y: 150, width: ScreenWidth, height: ScreenHeight - 150))
        textView.isEditable = false
        logView .addSubview(textView)
        
        self .readWorkLog()
        
        
        //刷新日志
        let refreshBtn = UIButton(frame: CGRect(x: 0, y: ScreenHeight - 120, width: 80, height: 30))
        logView .addSubview(refreshBtn)
        refreshBtn.titleLabel?.font = UIFont .systemFont(ofSize: 14)
        refreshBtn .setTitle("刷新日志", for: .normal)
        refreshBtn.backgroundColor = UIColor.blue
        refreshBtn .addTarget(self, action: #selector(readWorkLog), for: .touchUpInside)
        
        
        //清空打印日志
        let clearBtn = UIButton(frame: CGRect(x: 100, y: ScreenHeight - 120, width: 80, height: 30))
        logView .addSubview(clearBtn)
        clearBtn.titleLabel?.font = UIFont .systemFont(ofSize: 14)
        clearBtn .setTitle("清空日志", for: .normal)
        clearBtn.backgroundColor = UIColor.init(red: 0, green: 100, blue: 0, alpha: 1.0)
        clearBtn .setTitleColor(UIColor.black, for: .normal)
        clearBtn .addTarget(self, action: #selector(clearNSLog), for: .touchUpInside)
        
        
        //关闭日志
        let closeBtn = UIButton(frame: CGRect(x: 200, y: ScreenHeight - 120, width: 80, height: 30))
        logView .addSubview(closeBtn)
        closeBtn.titleLabel?.font = UIFont .systemFont(ofSize: 14)
        closeBtn .setTitle("关闭日志", for: .normal)
        closeBtn.backgroundColor = UIColor.red
        closeBtn .addTarget(self, action: #selector(closeLogShow), for: .touchUpInside)
        
        
        
        

    }
    
//    关闭日志显示
    @objc func closeLogShow(){
        isMove = true
        self.frame = CGRect(x: 0, y: ScreenHeight - 100, width: 60, height: 30)
        logView .removeFromSuperview()
        
    }
    
//    读取日志
    @objc func readWorkLog(){
        self .HGLog("刷新日志")

         let cachePath = FileManager.default.urls(for: .cachesDirectory,
                                                   in: .userDomainMask)[0]
         let logURL = cachePath.appendingPathComponent("log.txt")
         
        let data = FileManager.default.contents(atPath: logURL.path)
        let readString = String(data: data!, encoding: String.Encoding.utf8)
        textView.text = readString
        
        
        
    }
    
    
//    清空打印日志
    @objc func clearNSLog(){
        
        let cachePath = FileManager.default.urls(for: .cachesDirectory,
                                                                in: .userDomainMask)[0]
        let logURL = cachePath.appendingPathComponent("log.txt")
        
        try? FileManager.default .removeItem(at: logURL)
        
        self .HGLog("清空日志")

        self .readWorkLog()
        
        
    }
    
//    打印日志
    func HGLog<T>(_ message:T, file:String = #file, function:String = #function,
                 line:Int = #line) {
          #if DEBUG
              //获取文件名
              let fileName = (file as NSString).lastPathComponent
              //日志内容
              let consoleStr = "\(fileName):\(line) \(function) | \(message)"
              //打印日志内容
              print(consoleStr)
               
              // 创建一个日期格式器
              let dformatter = DateFormatter()
              // 为日期格式器设置格式字符串
              dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
              // 使用日期格式器格式化当前日期、时间
              let datestr = dformatter.string(from: Date())
               
              //将内容同步写到文件中去（Caches文件夹下）
              let cachePath = FileManager.default.urls(for: .cachesDirectory,
                                                        in: .userDomainMask)[0]
              let logURL = cachePath.appendingPathComponent("log.txt")
          print(logURL)
          
          
              appendText(fileURL: logURL, string: "\(datestr) \(consoleStr)")
          #endif
      }
      
    
    
    
    
    //在文件末尾追加新内容
      func appendText(fileURL: URL, string: String) {
          do {
              //如果文件不存在则新建一个
              if !FileManager.default.fileExists(atPath: fileURL.path) {
                  FileManager.default.createFile(atPath: fileURL.path, contents: nil)
              }
               
              let fileHandle = try FileHandle(forWritingTo: fileURL)
              let stringToWrite = "\n" + string
               
              //找到末尾位置并添加
              fileHandle.seekToEndOfFile()
              fileHandle.write(stringToWrite.data(using: String.Encoding.utf8)!)
               
          } catch let error as NSError {
              print("failed to append: \(error)")
          }
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
