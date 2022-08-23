//
//  Train_lines.swift
//  Yicheng_Li_Assignment2
//
//  Created by mac on 2021/5/4.
//

import Foundation

let train_line =
    [
    Train_lines(line:.Red,type:"Howard <-> 95th/Dan Ryan",name:"red"),
    Train_lines(line:.Blue,type:"O’Hare <-> Forest Park",name:"blue"),
    Train_lines(line:.Brown,type:"Kimball <-> Loop",name:"brn"),
    Train_lines(line:.Green,type:"Harlem/Lake <-> Ashland/63rd-Cottage Grove",name:"g"),
    Train_lines(line:.Orange,type:"Midway <-> Loop",name:"org"),
    Train_lines(line:.Pink,type:"54th/Cermak <-> Loop",name:"p"),
    Train_lines(line:.Purple,type:"Linden <-> Howard shuttle",name:"pink"),
    Train_lines(line:.Yellow,type:"Skokie <-> Howard [Skokie Swift] shuttle",name:"y")
    ]

class Train_lines
{
    enum `line`: String
    {
        case Red = "Red"
        case Blue = "Blue"
        case Brown = "Brown"
        case Green = "Green"
        case Orange = "Orange"
        case Pink = "Pink"
        case Purple = "Purple"
        case Yellow = "Yellow"
    }
    
    var line: line
    var type: String
    var name: String
    
    init(line: line, type: String, name:String)
    {
        self.line = line
        self.type = type
        self.name = name
    }
}
