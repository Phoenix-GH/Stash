//
//  ViewController.swift
//  Stash
//
//  Created by SamuelCardo on 11/11/16.
//  Copyright © 2016 CUBiC digital. All rights reserved.
//

import UIKit
import CSV
import PopupDialog

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var plusCell: UIView!
    @IBOutlet weak var table: UITableView!
    var messageArray:[NSMutableDictionary] = []
    var oArray:[NSMutableDictionary] = []
    
    var rowCount = 3
    var total:Float = 0
    var answered = 0
    
    @IBOutlet weak var totalValue: UILabel!
    
    @IBOutlet weak var stashValue: UIView!
    @IBOutlet weak var checkStash: UIView!
    @IBOutlet weak var setupAccount: UIView!
    @IBAction func plusTapped(_ sender: AnyObject) {
        self.oArray = []
        for var item in self.messageArray
        {
            let response = item.object(forKey: "positive") as! String?
            let answer = item.object(forKey: "answer") as! String?
            if(answer == nil)
            {
                self.oArray.append(item)
            }
        }
        self.messageArray = self.oArray
        self.table.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [UIColor(red: 87/255.0, green: 72/255.0, blue: 98/255.0, alpha: 1.0).cgColor, UIColor(red: 108/255.0, green: 90/255.0, blue: 124/255.0, alpha: 1.0).cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        self.view.layer.insertSublayer(gradient, at: 0)
        
        let csv = try! CSV(
            string: "coffee,m-f,y,Did you buy yourself a fancy coffee today?,N,congrates!! You didn't buy an expensive lattee!,2.50,The pricey coffee mounts up every day.,1.00,0\nlunch-out,m-f,y,Did you eat lunch out?,N,You brought a sandwich to work? Good job!,4.00,Eating lunch out will eat into your budget.,1.00,0\nnight-out,w-t-f,y,Did you go out last night?,N,Stayed home and watched movies? Nice saving!,7.00,Nights out are good but they can cost big time too,3.00,0\ncoupons,t-f-s-s,y,Did you clip some coupons and save yourself some money?,Y,Keep your cash in your pocket/ not in the 'man's' pocket!,3.00,Coupons can put some serious cash in your stash. Don't miss out!,1.00,0\ncredit-card-minimum,monthly,y,Did you only pay the minimum on your credit card?,N,Credit card debt is expensive!! Pay it off as soon as you can.,4.00,Paying the credit card company the mimnum means more of your money in their pockets!! Don't let that happen!,1.00,0\nnew-shoes,monthly,n,Did you need the new shoes or did you 'want' the new shoes?,Y,If you needed new shoes/ you need new shoes. Hope you got a good deal on them!,2.00,Sometimes you need stuff and you want stuff/ which is great/ and sometiem you only want stuff. Which means giving your money away!,2.00,0\nnew-clothes,monthly,n,New clothes are great! Did you need them or just want them?,Y,We have to look right for many reasons so you can't let your wardrobe go. You did get a good deal?,4.00,Sometime we things to make ourselves feel better or because we're bored. That kind of spending can cost you big in the long run!,2.00,0\ntook-the-bus,m-f,y,The daily commute can add up. Did you take the bus?,Y,Congrates on taking a more cost effective way to travel,1.00,Maybe you took a cheaper way to work/ but finding ways to spend less on everyday expenses means you hold on to more of your stash.,2.00,0\nmade-own-lunch,m-f,,Made your own lunch instead of buying?,Y,Congrates! Make your own meals is a great way to grow your stash,3.00,Eating lunch out? That means putting money in someone else's pockets. Why would you do that?,1.00,0\nbought-monthly-travel-pass,monthly,,Did you buy a monthly travel pass,Y,Buying in bulk/ even travel/ saves you cash. Congrates,3.00,Buying things in bulk can save you money. Even travel.,1.00,0\njoined-the-gym,monthly,n,Have you got  a gym membership?,Y,Having a gym membership can keep you healthy and not have to pay expensive health costs,5.00,A gym membership can save you money because it's better value than going out and it keeps you healthy. If you go.,2.00,0\nbought-clothes-on-sale,monthly,,Did you go shop for stuff on the sale?,Y,Ok/ you proably saved some money. Just make sure to return anything you didn't really need.,6.00,Most things end up on sale at some point which means you can keep more of your cash.,1.00,0\nstayed-in-last-night,tu-th-sa,,Stayed in and saved some cash?,Y,Staying home is great way to find cash to stash!,6.00,Going out is fun and that’s a great part of life but don't give away too much cash to the hospitality industry!,2.00,0\ncheap-gas,fr-sa-su,,Do you get the best deal on gas is in your neighborhood?,Y,Saving on gas is saving  cash!! Keep up the good work,2.50,The big oil companies have plenty of cash. There's no need to give them anymore of yours.,1.00,0\ncut-the-cord,monthly,,Are you paying for cable TV?,N,Cable TV can really cost you. There's lots of ways to watch TV and movies without paying for cable,3.00,There's plenty of ways to watch TV and movies without a cable subsrcition. Cut the cord and stash your cash!,1.00,0\nplan-spring-break-now,jan feb mar,,You're probably planning on taking a Spring break?,Y,If so/ you should start saving some cash about now.,5.00,If you're staying near home this spring break you can put some money away for the summer!,1.00,0",
            hasHeaderRow: false) // default: false
        
        
        for row in csv {    
            
            let dictionary = NSMutableDictionary()
            dictionary.setValue(row[0], forKey: "word")
            dictionary.setValue(row[1], forKey: "frequency")
            dictionary.setValue(row[2], forKey: "repeating question")
            dictionary.setValue(replace(row[3]), forKey: "question")
            dictionary.setValue(row[4], forKey: "positive")
            dictionary.setValue(replace(row[5]), forKey: "positive response")
            dictionary.setValue(row[6], forKey: "stash value")
            dictionary.setValue(replace(row[7]), forKey: "negative response")
            dictionary.setValue(row[8], forKey: "fine value")
            dictionary.setValue(row[9], forKey: "don't show again")
            self.messageArray.append(dictionary)
            self.setupAccount.alpha = 1
            self.checkStash.alpha = 0
            self.stashValue.alpha = 0
            let stashGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.showCheckStash(_:)))
            
            let valueGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.showStashedValue(_:)))
            self.setupAccount.addGestureRecognizer(stashGesture)
            self.checkStash.addGestureRecognizer(valueGesture)
        }
        
        loadingAnimation()
        
    }
    
    func showCheckStash(_ sender:UITapGestureRecognizer){
        UIView.animate(withDuration: 0.5, animations: {
            self.setupAccount.alpha = 0
            self.checkStash.alpha = 1
            self.stashValue.alpha = 0
            })

    }
    
    func showStashedValue(_ sender:UITapGestureRecognizer){
        let title = "THIS IS THE DIALOG TITLE"
        let message = "This is the message section of the popup dialog default view"
        let image = UIImage(named: "coloredfinger")
        
        // Create the dialog
        let popup = PopupDialog(title: title, message: message, image: image)
        
        // Create buttons
        let buttonTwo = DefaultButton(title: "Enter Passcode") {
            UIView.animate(withDuration: 0.5, animations: {
                self.setupAccount.alpha = 0
                self.checkStash.alpha = 0
                self.stashValue.alpha = 1
            })

        }
        
        let buttonOne = CancelButton(title: "CANCEL") {
            print("You canceled the car dialog.")
        }
        
        // Add buttons to dialog
        // Alternatively, you can use popup.addButton(buttonOne)
        // to add a single button
        popup.addButtons([ buttonTwo,buttonOne])
        
        // Present dialog
        self.present(popup, animated: true, completion: nil)
        
    }
    
    func loadingAnimation() {
        self.table.reloadData()
        self.table.transform = CGAffineTransform(scaleX: 1, y: 0.01)
        self.plusCell.transform = CGAffineTransform(translationX: self.plusCell.frame.size.width, y: 0)
        
        let cell = self.table.cellForRow(at: NSIndexPath(row: 0, section: 0) as IndexPath) as! AnimationCell
        cell.lblText.transform = CGAffineTransform(translationX: -cell.lblText.frame.size.width, y: 0)
        cell.buttonView.transform = CGAffineTransform(translationX: cell.buttonView.frame.size.width, y: 0)
        
        let cell2 = self.table.cellForRow(at: NSIndexPath(row: 1, section: 0) as IndexPath) as! AnimationCell
        cell2.lblText.transform = CGAffineTransform(translationX: -cell2.lblText.frame.size.width, y: 0)
        cell2.buttonView.transform = CGAffineTransform(translationX: cell2.buttonView.frame.size.width, y: 0)
        
        let cell3 = self.table.cellForRow(at: NSIndexPath(row: 2, section: 0) as IndexPath) as! AnimationCell
        cell3.lblText.transform = CGAffineTransform(translationX: -cell3.lblText.frame.size.width, y: 0)
        cell3.buttonView.transform = CGAffineTransform(translationX: cell3.buttonView.frame.size.width, y: 0)
        self.table.frame.size.height -= CGFloat(105 * self.messageArray.count)
        UIView.animate(withDuration:1, delay: 0,  animations: {
            self.table.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.table.frame.size.height  += CGFloat(105 * self.messageArray.count)
            
            }, completion: { finished in
                
                UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
                    cell.lblText.transform = CGAffineTransform(translationX: 0, y: 0)
                    cell.buttonView.transform = CGAffineTransform(translationX: 0, y: 0)
                    UIView.animate(withDuration: 1, delay: 0.3, options: .curveEaseInOut, animations: {
                        cell2.lblText.transform = CGAffineTransform(translationX: 0, y: 0)
                        cell2.buttonView.transform = CGAffineTransform(translationX: 0, y: 0)
                        UIView.animate(withDuration: 1, delay: 0.6, options: .curveEaseInOut, animations: {
                            cell3.lblText.transform = CGAffineTransform(translationX: 0, y: 0)
                            cell3.buttonView.transform = CGAffineTransform(translationX: 0, y: 0)
                            
                            }, completion: { finished in
                                UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
                                    
                                    self.plusCell.transform = CGAffineTransform(translationX: 0, y: 0)
                                    }, completion: { finished in
                                        
                                })
                                
                                self.calculateTotal()
                                self.table.reloadData()
                                
                        })
                        }, completion: { finished in
                    })
                    
                    }, completion: { finished in
                        
                })
        })

    }
    override func viewDidLayoutSubviews() {
        self.table .reloadData()
    }
    
    @IBOutlet weak var plusTapped: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return min(self.messageArray.count, 3)
    }
    
    
    func replace(_ string:String) ->String
    {
        
        let newString = string.replacingOccurrences(of: "/", with: ",", options: .literal, range: nil)
        return newString
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:AnimationCell = tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath) as! AnimationCell
        
        if(indexPath.row < rowCount)
        {
            
            cell.parent = self
            cell.btnYes.layer.cornerRadius = cell.btnYes.frame.width/2.0;
            cell.btnYes.layer.masksToBounds = true
            cell.btnYes.layer.borderColor = UIColor.white.cgColor
            cell.btnYes.layer.borderWidth = 3.0
            cell.btnNo.layer.cornerRadius = cell.btnNo.frame.width/2.0;
            cell.btnNo.layer.masksToBounds = true
            cell.btnNo.layer.borderColor = UIColor.white.cgColor
            cell.btnNo.layer.borderWidth = 3.0
            cell.btnYes.tag = indexPath.row*2
            cell.btnNo.tag = indexPath.row*2+1
            cell.btnPlus.tag = indexPath.row
            cell.btnMinus.tag = indexPath.row
            let gradient: CAGradientLayer = CAGradientLayer()
            if(indexPath.row == 0)
            {
                gradient.colors = [UIColor(red: 174/255.0, green: 55/255.0, blue: 39/255.0, alpha: 1.0).cgColor, UIColor(red: 218/255.0, green: 69/255.0, blue: 49/255.0, alpha: 1.0).cgColor]
                cell.btnYes.backgroundColor = UIColor(red: 192/255.0, green: 60/255.0, blue: 43/255.0, alpha: 1.0)
                
                cell.btnNo.backgroundColor = UIColor(red: 205/255.0, green: 65/255.0, blue: 46/255.0, alpha: 1.0)
                
            }
            else if(indexPath.row == 1)
            {
                gradient.colors = [UIColor(red: 203/255.0, green: 142/255.0, blue: 76/255.0, alpha: 1.0).cgColor, UIColor(red: 254/255.0, green: 177/255.0, blue: 95/255.0, alpha: 1.0).cgColor]
                cell.btnYes.backgroundColor = UIColor(red: 236/255.0, green: 164/255.0, blue: 88/255.0, alpha: 1.0)
                
                cell.btnNo.backgroundColor = UIColor(red: 228/255.0, green: 159/255.0, blue: 85/255.0, alpha: 1.0)
                cell.leftView.backgroundColor = UIColor(red: 203/255.0, green: 142/255.0, blue: 76/255.0, alpha: 1.0)
                cell.rightView.backgroundColor = UIColor(red: 249/255.0, green: 189/255.0, blue: 125/255.0, alpha: 1.0)
                
                cell.btnPlus.setImage(UIImage(named: "p2"), for: UIControlState.normal)
                cell.btnMinus.setImage(UIImage(named: "m2"), for: UIControlState.normal)
            }
            else if(indexPath.row == 2)
            {
                
                gradient.colors = [UIColor(red: 128/255.0, green: 142/255.0, blue: 76/255.0, alpha: 1.0).cgColor, UIColor(red: 160/255.0, green: 187/255.0, blue: 178/255.0, alpha: 1.0).cgColor]
                cell.btnYes.backgroundColor = UIColor(red: 141/255.0, green: 165/255.0, blue: 156/255.0, alpha: 1.0)
                
                cell.btnNo.backgroundColor = UIColor(red: 150/255.0, green: 175/255.0, blue: 167/255.0, alpha: 1.0)
                
                cell.leftView.backgroundColor = UIColor(red: 137/255.0, green: 160/255.0, blue: 152/255.0, alpha: 1.0)
                cell.rightView.backgroundColor = UIColor(red: 172/255.0, green: 193/255.0, blue: 185/255.0, alpha: 1.0)
                
                cell.btnPlus.setImage(UIImage(named: "p3"), for: UIControlState.normal)
                cell.btnMinus.setImage(UIImage(named: "m3"), for: UIControlState.normal)
                
            }
            
            gradient.locations = [0.0 , 1.0]
            gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradient.frame = CGRect(x: 0.0, y: 0.0, width: cell.mainView.frame.size.width, height: cell.mainView.frame.size.height)
            
            cell.mainView.layer.insertSublayer(gradient, at: 0)
            
            let item = self.messageArray[indexPath.row]
            
            cell.lblText.text = item.object(forKey: "question") as! String?
            let response = item.object(forKey: "positive") as! String?
            let answer = item.object(forKey: "answer") as! String?
            if(answer != nil)
            {
                cell.leftView.transform = CGAffineTransform(translationX: cell.leftView.frame.size.width, y: 0)
                cell.rightView.transform = CGAffineTransform(translationX: -cell.rightView.frame.size.width, y: 0)
                if(response == answer)
                {
                    cell.leftMessage.text = item.object(forKey: "positive response") as! String?
                    cell.rightMessage.text = "STASH"
                    cell.rightAmount.text = item.object(forKey: "stash value") as! String?
                    
                }
                else
                {
                    cell.leftMessage.text = item.object(forKey: "negative response") as! String?
                    cell.rightMessage.text = "FINE"
                    cell.rightAmount.text = item.object(forKey: "fine value") as! String?
                }
            }
            else
            {
                cell.leftView.transform = CGAffineTransform(translationX: -cell.leftView.frame.size.width, y: 0)
                cell.rightView.transform = CGAffineTransform(translationX: cell.rightView.frame.size.width, y: 0)
            }
        }
        
    
        return cell
    }
    
    public func calculateTotal()
    {
        self.total = 0
        let item:NSMutableDictionary;
        for item in self.messageArray
        {
            let response = item.object(forKey: "positive") as! String?
            let answer = item.object(forKey: "answer") as! String?
            if(answer != nil)
            {
                if(response == answer)
                {
                    self.total = self.total + (item.object(forKey: "stash value") as! NSString).floatValue
                }
                else
                {
                    self.total = self.total - (item.object(forKey: "fine value") as! NSString).floatValue
                }
            }

        }
        self.totalValue.text = NSString.init(format: "$%.2f", self.total) as String
        
    }
    
}

