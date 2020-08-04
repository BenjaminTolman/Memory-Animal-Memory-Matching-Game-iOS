//
//  ViewController.swift
//  Memory Animal
//
//  Created by Benjamin Tolman on 6/9/20.
//  Copyright © 2020 Benjamin Tolman. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class ViewController: UIViewController {
    
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let context = appDelegate.persistentContainer.viewContext
    
    @IBOutlet weak var img00: UIButton!
    @IBOutlet weak var img01: UIButton!
    @IBOutlet weak var img02: UIButton!
    @IBOutlet weak var img03: UIButton!
    @IBOutlet weak var img04: UIButton!
    @IBOutlet weak var img05: UIButton!
    @IBOutlet weak var img06: UIButton!
    @IBOutlet weak var img07: UIButton!
    @IBOutlet weak var img08: UIButton!
    @IBOutlet weak var img09: UIButton!
    @IBOutlet weak var img10: UIButton!
    @IBOutlet weak var img11: UIButton!
    @IBOutlet weak var img12: UIButton!
    @IBOutlet weak var img13: UIButton!
    @IBOutlet weak var img14: UIButton!
    @IBOutlet weak var img15: UIButton!
    @IBOutlet weak var img16: UIButton!
    @IBOutlet weak var img17: UIButton!
    @IBOutlet weak var img18: UIButton!
    @IBOutlet weak var img19: UIButton!
    
    //iPad extra images
    @IBOutlet weak var img20: UIButton!
    @IBOutlet weak var img21: UIButton!
    @IBOutlet weak var img22: UIButton!
    @IBOutlet weak var img23: UIButton!
    @IBOutlet weak var img24: UIButton!
    @IBOutlet weak var img25: UIButton!
    @IBOutlet weak var img26: UIButton!
    @IBOutlet weak var img27: UIButton!
    @IBOutlet weak var img28: UIButton!
    @IBOutlet weak var img29: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    //Sound variables.
    var cardSoundEffect: AVAudioPlayer?
    var pointSoundEffect: AVAudioPlayer?
    var winSoundEffect: AVAudioPlayer?
    
    //Leaderboard
    var moves = 0
    var leaders = [LeaderBoardPlayer]()
    
    //Timer variables.
    var timer = Timer()
    var seconds = 0
    var minutes = 0
    
    //Buttons
    var buttons = [UIButton]()
    
    //References to images
    var images = [UIImage]()
    
    //If ipad each half is 16, phone is 10.
    var cards = [Card]()
    
    //Add and remove these as built and matched.
    var cardsLeft = 0
    
    //How many cards picked so far.
    var cardsPicked = 0
    
    //Can pick another card?
    var cardsFlipped = 0
    
    //Is this the iPad version?
    var iPadVersion = false
    
    var pickingAllowed = true
    
    //Cards in play
    var cardTagOne = 0
    var cardTagTwo = 0
    var cardOne: Card?
    var cardTwo: Card?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttons = [img00, img01, img02, img03, img04, img05, img06, img07, img08, img09, img10, img11, img12, img13, img14, img15, img16, img17, img18, img19, img20, img21, img22, img23, img24, img25, img26, img27, img28, img29]
        
        //Make all buttons aspect fit images.
        for b in buttons
        {
            b.imageView?.contentMode = .scaleAspectFit
            b.layer.cornerRadius = 5
        }
        
        images = [#imageLiteral(resourceName: "bear"),#imageLiteral(resourceName: "whale"),#imageLiteral(resourceName: "zebra"),#imageLiteral(resourceName: "frog"),#imageLiteral(resourceName: "chick"),#imageLiteral(resourceName: "panda"),#imageLiteral(resourceName: "snake"),#imageLiteral(resourceName: "horse"),#imageLiteral(resourceName: "dog"),#imageLiteral(resourceName: "parrot"),#imageLiteral(resourceName: "cow"),#imageLiteral(resourceName: "pig"),#imageLiteral(resourceName: "monkey"),#imageLiteral(resourceName: "elephant"),#imageLiteral(resourceName: "crocodile")]
        
        timeLabel.text = "Time 00:00"
        
        resetGame(name: "none")
        
        load()
    }
    
    @IBAction func cardTapped(_ sender: UIButton) {
        
        //If 2 cards arent flipped yet.
        if(cardsFlipped < 2 && pickingAllowed)
        {
            playSound(sound: 0)
            //Get card id from tag / cardsArray.
            let id = (cards[sender.tag].id)
            
            //Set the image.
            buttons[sender.tag].setImage(images[id], for: .normal)
            
            if cardOne == nil
            {
                cardOne = cards[sender.tag]
                cardTagOne = sender.tag
                
                cardsFlipped += 1
            }
                
            else
            {
                if(sender.tag == cardTagOne){return}
                //Same card protection.
                cardTwo = cards[sender.tag]
                cardTagTwo = sender.tag
                
                //Match
                if cardTwo?.id == cardOne?.id{
                    
                    self.moves += 1
                    
                    playSound(sound: 1)
                    
                    self.pickingAllowed = false
                    
                    //Wait for half a second before ending.
                    let secondsToDelay = 0.5
                    DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) {
                        
                        //Remove cards.
                        self.buttons[self.cardTagOne].isEnabled = false
                        self.buttons[self.cardTagTwo].isEnabled = false
                        self.buttons[self.cardTagOne].isHidden = true
                        self.buttons[self.cardTagTwo].isHidden = true
                        
                        self.cardTwo = nil
                        self.cardOne = nil
                        
                        self.cardsFlipped = 0
                        
                        self.cardsLeft -= 2
                        
                        if(self.cardsLeft >= 2)
                        {
                            self.pickingAllowed = true
                        }
                        else{
                            
                            self.playSound(sound: 2)
                            
                            //Stop timer.
                            self.timer.invalidate()
                            
                            //Create the alert controller.
                            let alertController = UIAlertController(title: "Congratulations!", message: "You completed Memory Animal with a time of \( self.timeLabel?.text ?? "Unknown") Enter name to post to the Leaderboard", preferredStyle: .alert)
                            
                            alertController.addTextField()
                            
                            //Create the actions.
                            let resetAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
                                UIAlertAction in
                                self.resetGame(name: alertController.textFields![0].text ?? "none")
                            }
                            //Add the action.
                            
                            alertController.addAction(resetAction)
                            
                            //Present the controller.
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                }
                else
                {
                    //No match.
                    self.pickingAllowed = false
                    
                    self.moves += 1
                    
                    let secondsToDelay = 0.5
                    DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) {
                        
                        self.buttons[self.cardTagOne].setImage(nil, for: .normal)
                        self.buttons[self.cardTagTwo].setImage(nil, for: .normal)
                        
                        self.cardTwo = nil
                        self.cardOne = nil
                        
                        self.cardsFlipped = 0
                        
                        self.pickingAllowed = true
                    }
                }
            }
        }
    }
    
    func resetGame(name: String)
    {
        //If name was added then add to leaderboard.
        if name != "none"{
            
            var newTime = "0.0"
            
            if(seconds < 10)
            {
                newTime = "\(minutes).0\(seconds)"
            }
            else
            {
                newTime = "\(minutes).\(seconds)"
            }
            
            let timestamp = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .short)
            
            leaders.append(LeaderBoardPlayer(time: newTime, name: name, moves: self.moves, date: timestamp))
            
            save()
        }
        
        moves = 0;
        
        cards.removeAll()
        
        //If this is in ipad.
        if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular {
            
            for index in 0...14{
                cards.append(Card(id: index,img: images[index]))
                cards.append(Card(id: index,img: images[index]))
            }
            cardsLeft = 30
        }
            
        else{
            
            //If phone of any size.
            for index in 0...9{
                cards.append(Card(id: index,img: images[index]))
                cards.append(Card(id: index,img: images[index]))
            }
            cardsLeft = 20
        }
        
        //Shuffle the cards.
        cards.shuffle()
        
        self.pickingAllowed = false
        
        //Set all buttons to normal.
        for b in buttons
        {
            b.setImage(nil, for: .normal)
            b.isEnabled = true
            b.isEnabled = true
            b.isHidden = false
            b.isHidden = false
        }
        
        timeLabel.text = "00:00"
        seconds = 0
        minutes = 0
        playButton.isEnabled = true
        playButton.isHidden = false
    }
    
    func startGame(){
        
        //Show images.
        for (index, _) in cards.enumerated(){
            let tag = index
            buttons[tag].setImage(images[cards[tag].id], for: .normal)
        }
        
        //Wait 5 seconds.
        let secondsToDelay = 5.0
        DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) {
            
            //Hide the images again.
            for (index, _) in self.cards.enumerated(){
                let tag = index
                self.buttons[tag].setImage(nil, for: .normal)
            }
            
            self.pickingAllowed = true
            
            //Start the timer.
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.increment), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        
        startGame()
        
        playButton.isEnabled = false
        playButton.isHidden = true
    }
    
    //Incrementing the timer.
    @objc func increment()
    {
        seconds += 1
        
        if seconds >= 60
        {
            seconds = 0
            minutes += 1
        }
        
        var secondsText = ""
        if seconds < 10{
            secondsText = "0\(seconds)"
        }
        else
        {
            secondsText = "\(seconds)"
        }
        var minutesText = ""
        if minutes < 10{
            minutesText = "0\(minutes)"
        }
        else
        {
            secondsText = "\(minutes)"
        }
        
        timeLabel.text = "\(minutesText):\(secondsText)"
    }
    
    //This plays sounds for certain things based on a switch int.
    func playSound(sound: Int)
    {
        switch sound{
        case 0: //card sound.
            let path = Bundle.main.path(forResource: "draw.wav", ofType:nil)!
            let url = URL(fileURLWithPath: path)
            
            do {
                cardSoundEffect = try AVAudioPlayer(contentsOf: url)
                cardSoundEffect?.play()
            } catch {
                return //sound couldn't be played.
            }
        case 1: //Success sound.
            let path = Bundle.main.path(forResource: "point.wav", ofType:nil)!
            let url = URL(fileURLWithPath: path)
            
            do {
                pointSoundEffect = try AVAudioPlayer(contentsOf: url)
                pointSoundEffect?.play()
            } catch {
                return //sound couldn't be played.
            }
        case 2: //Win sound.
            let path = Bundle.main.path(forResource: "win.wav", ofType:nil)!
            let url = URL(fileURLWithPath: path)
            
            do {
                winSoundEffect = try AVAudioPlayer(contentsOf: url)
                winSoundEffect?.play()
            } catch {
                return //sound couldn't be played.
            }
        default:
            return
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? LeadersViewController
        {
            dest.leaders = self.leaders
        }
    }
    
    //Save to core data.
    func save(){
        
        //Delete Previous (This ended up not being needed but I keped it here to avoid a last minute bug)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Players")
        request.returnsObjectsAsFaults = false
        
        do{
            let result = try context.fetch(request)
            
            for data in result as! [NSManagedObject]{
                context.delete(data)
            }
        }
        catch{print("failed Delete")}
        
        let entity = NSEntityDescription.entity(forEntityName: "Players", in: context)!
        //Add data
        //create a new user record
        for l in leaders{
            
            let newUser = NSManagedObject(entity: entity, insertInto: context)
            
            newUser.setValue(l.name, forKey: "names")
            newUser.setValue(l.time, forKey: "times")
            newUser.setValue(l.moves, forKey: "move")
            newUser.setValue(l.date, forKey: "dates")
        }
        
        do{
            try context.save()
        }
        catch{
            print("save failed")
        }
    }
    
    //Load player data and then add them to the leaders array.
    func load(){
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Players")
        
        request.returnsObjectsAsFaults = false
        
        do{
            let result = try context.fetch(request)
            
            //Loop to get data
            for data in result as! [NSManagedObject]{
                let name = data.value(forKey: "names") as! String
                let date = data.value(forKey: "dates") as! String
                let move = data.value(forKey: "move") as! Int
                let times = data.value(forKey: "times") as! String
                
                let player = LeaderBoardPlayer(time: times, name: name, moves: move, date: date)
                self.leaders.append(player)
            }
        }
        catch{
            print("failed load")
        }
    }
    
    //Delete data for leaderboards from core data then remove from the array.
    @IBAction func deleteData(){
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Players")
        
        request.returnsObjectsAsFaults = false
        
        do{
            let result = try context.fetch(request)
            
            //Loop to get data
            
            for data in result as! [NSManagedObject]{
                context.delete(data)
            }
        }
        catch{
            print("failed load")
        }
        do{
            try context.save()
        }
        catch{
            print("delete failed")
        }
        
        leaders.removeAll()
    }
}


