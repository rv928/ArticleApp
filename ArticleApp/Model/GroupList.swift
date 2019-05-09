//
//  GroupList.swift
//  ArticleApp


import Foundation


class Group {
    
    var groupType:Int?
    var groupObject:Array<String>? = Array()

    init(dictionary: Dictionary<String,Any>) {
        
        if dictionary.isEmpty == false {
            groupType = dictionary[ResponseConstant.groupType] as? Int
            groupObject = dictionary[ResponseConstant.groupObject] as? Array<String>
        }
    }
}
