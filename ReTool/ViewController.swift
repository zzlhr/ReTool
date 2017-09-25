//
//  ViewController.swift
//  ReTool
//
//  Created by lhr on 2017/9/24.
//  Copyright © 2017年 lhr. All rights reserved.
//

import Cocoa



class ViewController: NSViewController,NSTableViewDataSource,NSTableViewDelegate {

    
    
    @IBOutlet var text: NSTextView!
    
    @IBOutlet weak var reText: NSTextField!
    
    
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var button: NSButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    var data = [String]()
    
    @IBAction func onclick(_ sender: Any){
        //获取正则表达式
        let pattern = reText.stringValue
        //获取待匹配文本
        let matched = text.accessibilityValue()
        
        NSLog("regex:"+pattern+"\n"+"matched:"+matched!)
        if pattern == "" || matched == ""{
            let alert = NSAlert()
            
            alert.messageText = "非法操作："
            alert.informativeText = "待匹配的内容和正则表达式不能为空"
            alert.addButton(withTitle: "确认")
            alert.runModal()
            return
        }
        let result: [Res] = check(pattern: pattern, text: matched!)
        data.removeAll()
        for re in result{
            let maStr = NSString(string: matched!)
            let str = maStr.substring(with:NSMakeRange(re.location, re.length))
            data.append(str)
            
            NSLog(str)
        }
        tableView.reloadData()
        
    }
    
    private func check(pattern: String, text: String) -> [Res] {
        do{
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            
            let res = regex.matches(in: text, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, text.characters.count))
            var result = [Res]()
            for re in res{
                let ress = Res()
                let reContainer: Res = ress.set(location: re.range.location, length: re.range.length)
                result.append(reContainer)
            }
            return result
        }
        catch {
            NSLog(error as! String)
        }
        return [Res()];
    }
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return data.count
    }
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        
        return data[row]
    }
    


}

