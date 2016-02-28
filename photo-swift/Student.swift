//
//  Student.swift
//  photo-swift
//
//  Created by admin on 16/2/25.
//  Copyright © 2016年 admin. All rights reserved.
//

import UIKit
import JavaScriptCore


@objc protocol StudentJS:JSExport{
    func takePhoto()
}

protocol takePhotoDelegate{
    func gotoTakePhoto()
}


class Student: NSObject,StudentJS{
    var delegate:takePhotoDelegate?
    func takePhoto(){
        print("hello")
        delegate?.gotoTakePhoto()
    }
}


