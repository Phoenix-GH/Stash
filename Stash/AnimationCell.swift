//
//  AnimationCell.swift
//  Stash
//
//  Created by Andy on 11/14/16.
//  Copyright © 2016 CUBiC digital. All rights reserved.
//

import UIKit

class AnimationCell: UITableViewCell {
    
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var leftMessage: UILabel!
    @IBOutlet weak var rightMessage: UILabel!
    @IBOutlet weak var rightAmount: UILabel!
    @IBOutlet weak var buttonView: UIView!
    
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    
    var parent:ViewController? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func plusTapped(_ sender: AnyObject) {
        var but:UIButton
        but = sender as! UIButton
        let row = sender.tag
        let rowItem =  parent?.messageArray[row!]
        let response = rowItem?.object(forKey: "positive") as! String?
        let answer = rowItem?.object(forKey: "answer") as! String?
        var value:Float
        if(response == answer)
        {
            value = (rowItem?.object(forKey: "stash value") as! NSString).floatValue
            value = value + 0.1
            let s = NSString(format: "%.2f", value)
            rowItem?.setObject(s, forKey: "stash value" as NSCopying)
            
        }
        else
        {
            value = (rowItem?.object(forKey: "fine value") as! NSString).floatValue
            value = value + 0.1
            let s = NSString(format: "%.2f", value)
            rowItem?.setObject(s, forKey: "fine value" as NSCopying)
        }
       
        parent?.messageArray[row!] = rowItem!
        self.parent?.table.reloadData()
    }
    @IBAction func minusTapped(_ sender: AnyObject) {
        var but:UIButton
        but = sender as! UIButton
        let row = sender.tag
        let rowItem =  parent?.messageArray[row!]
        let response = rowItem?.object(forKey: "positive") as! String?
        let answer = rowItem?.object(forKey: "answer") as! String?
        var value:Float
        if(response == answer)
        {
            value = (rowItem?.object(forKey: "stash value") as! NSString).floatValue
            value = value - 0.1
            let s = NSString(format: "%.2f", value)
            rowItem?.setObject(s, forKey: "stash value" as NSCopying)
            
        }
        else
        {
            value = (rowItem?.object(forKey: "fine value") as! NSString).floatValue
            value = value - 0.1
            let s = NSString(format: "%.2f", value)
            rowItem?.setObject(s, forKey: "fine value" as NSCopying)
        }
        
        
        parent?.messageArray[row!] = rowItem!
        self.parent?.table.reloadData()

    }

    
    @IBAction func yesTapped(_ sender: AnyObject) {
        var but:UIButton
        but = sender as! UIButton
        let row = sender.tag / 2
        let button = sender.tag % 2
        let rowItem =  parent?.messageArray[row]
        rowItem?.setValue("1", forKey: "don't show again")
        
        
        if(button == 0)
        {
            rowItem?.setValue("Y", forKey: "answer")
        }
        else
        {
            rowItem?.setValue("N", forKey: "answer")
        }
        
        let response = rowItem?.object(forKey: "positive") as! String?
        let answer = rowItem?.object(forKey: "answer") as! String?
        
        if(response == answer)
        {
            self.leftMessage.text = rowItem?.object(forKey: "positive response") as! String?
            self.rightMessage.text = "STASH"
            self.rightAmount.text = rowItem?.object(forKey: "stash value") as! String?
            
        }
        else
        {
            self.leftMessage.text = rowItem?.object(forKey: "negative response") as! String?
            self.rightMessage.text = "FINE"
            self.rightAmount.text = rowItem?.object(forKey: "fine value") as! String?
        }
        parent?.messageArray[row] = rowItem!
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            
            self.leftView.transform = CGAffineTransform(translationX: self.leftView.frame.size.width, y: 0)
            self.rightView.transform = CGAffineTransform(translationX: -self.rightView.frame.size.width, y: 0)
            
            }, completion: { finished in
                self.parent?.calculateTotal()
                self.parent?.table.reloadData()
                
        })
    }
    
}
