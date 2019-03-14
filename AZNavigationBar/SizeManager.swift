//
//  SizeManager.swift
//  AZNavigationBar
//
//  Created by cocozzhang on 2019/3/11.
//  Copyright © 2019 cocozzhang. All rights reserved.
//

import Foundation
import UIKit

class SizeManager: NSObject {
    static let shared = SizeManager()
    
    private override init() {
    }
    
    var titleWidth:CGFloat = CGFloat(UIScreen.main.bounds.width)
    var leftWidth:CGFloat = CGFloat(40)
    var rightWidth:CGFloat = CGFloat(40)
    
    var titleLabelWidth:CGFloat = CGFloat(UIScreen.main.bounds.width)
    var titleLabelLeft:CGFloat = CGFloat(0)
}
