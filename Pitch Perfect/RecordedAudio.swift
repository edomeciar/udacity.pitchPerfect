//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Eduard Meciar on 04/11/15.
//  Copyright © 2015 Eduard Meciar. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl:NSURL!,title:String!) {
        self.filePathUrl = filePathUrl
        self.title = title
    }

}
