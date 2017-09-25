//
//  Res.swift
//  ReTool
//
//  Created by lhr on 2017/9/24.
//  Copyright © 2017年 lhr. All rights reserved.
//

import Foundation
class Res {
    var location : Int = 0
    var length: Int = 0
    
    func set(location: Int, length:Int) -> Res{
        self.location = location
        self.length = length
        return self
    }
    
    
}
