//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Xavier Jorda Murria on 27/08/2015.
//
//

import Foundation

class RecordedAudio: NSObject
{
    private var privateFilePathUrl: NSURL!
    private var privateTitle: String!
    
    init(_filePathUrl: NSURL, _title:String)
    {
        self.privateFilePathUrl = _filePathUrl
        self.privateTitle = _title
    }
    
    var filePathUrl: NSURL!
        {
        set(newValue)
        {
            if newValue != privateFilePathUrl
            {
                privateFilePathUrl = newValue;
                // do whatever I want
            }
        }
        get
        {
            return privateFilePathUrl;
        }
    }
    
    var title: String!
        {
        set(newValue)
        {
            if newValue != privateTitle
            {
                privateTitle = newValue;
                // do whatever I want
            }
        }
        get
        {
            return privateTitle;
        }
    }
}
