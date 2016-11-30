//
//  Natures.swift
//  Celadon
//
//  Created by Jim Boulter on 11/30/16.
//  Copyright © 2016 Jim Boulter. All rights reserved.
//

import Foundation

enum Nature : NatureEffect {
    case hardy = "\(Stat.none),\(Stat.none)"
    case lonely
    case brave
    case adamant
    case naughty
    case bold
    case docile
    case relaxed
    case impish
    case lax
    case timid
    case hasty
    case serious
    case jolly
    case naive
    case modest
    case mild
    case quiet
    case bashful
    case rash
    case calm
    case gentle
    case sassy
    case careful
    case quirky
}

struct NatureEffect : StringLiteralConvertable {
    var increasedStat:Stat?
    var decreasedStat:Stat?
    
    init(_ increased:Stat? = nil, _ decreased:Stat? = nil) {
        increasedStat = increased
        decreasedStat = decreased
    }
    
    static func convertFromStringLiteral(value:String) -> NatureEffect {
        
        let arr = value.components(separatedBy:",").map(Int.init)
        if let inc = Stat(rawValue:arr.first), let dec = Stat(rawValue:arr.last) {
            return NatureEffect(inc, dec)
        }
        
        return NatureEffect(Stat.none, Stat.none)
    }
    
    func stringValue() -> String {
        return "\(increasedStat),\(decreasedStat)"
    }
    
    // Has to do with poffins and stuff
    // Do much later
    //var favoriteFlavor:Flavor
    //var dislikedFlavor:Flavor
}
