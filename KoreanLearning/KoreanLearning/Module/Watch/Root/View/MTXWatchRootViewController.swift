//
//  MTXWatchRootViewController.swift
//  KoreanLearning
//
//  Created by MountainX on 2018/5/9.
//  Copyright © 2018年 MTX Software Technology Co.,Ltd. All rights reserved.
//

import UIKit
import Cards

class MTXWatchRootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        let cardMargin: CGFloat = 20
        let cardW = (view.bounds.size.width - 3 * cardMargin) / 2
        let cardH = cardW * 1.5
        
        //ScollView
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: STATUS_BAR_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - STATUS_BAR_HEIGHT - TAB_BAR_HEIGHT))
        scrollView.contentSize = CGSize(width: view.bounds.size.width, height: 3 * cardH + 4 * cardMargin)
        view.addSubview(scrollView)
        
        //MARK: CardPlayer
        let card = CardPlayer.init(frame: CGRect(x: cardMargin, y: 20, width: cardW, height: cardH))
        scrollView.addSubview(card)
        
        card.videoSource = URL(string: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        card.shouldDisplayPlayer(from: self)    //Required.
        
        card.playerCover = UIImage(named: "mvBackground")!  // Shows while the player is loading
        card.playImage = UIImage(named: "CardPlayerPlayIcon")!  // Play button icon
        
        card.isAutoplayEnabled = false
        card.shouldRestartVideoWhenPlaybackEnds = true
        
        card.title = "Big Buck Bunny"
        card.subtitle = "Inside the extraordinary world of Buck Bunny"
        card.category = "today's movie"
        
        //cardContent
        let cardContent = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CardContent")
        //this initialization cause cardContent become nil
        //        let cardContent = storyboard?.instantiateViewController(withIdentifier: "CardContent")
        card.shouldPresent(cardContent, from: self)
        
        //MARK: CardHighlight
        let card2 = CardHighlight.init(frame: CGRect(x: card.frame.maxX + cardMargin, y: card.frame.minY, width: cardW, height: cardH))
        scrollView.addSubview(card2)
        card2.backgroundImage = #imageLiteral(resourceName: "flBackground")
        //cardContent
        let cardContent2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CardContent")
        card2.shouldPresent(cardContent2, from: self, fullscreen: true)
        
        //MARK: CardGroup
        let card3 = CardGroup.init(frame: CGRect(x: card.frame.minX, y: card.frame.maxY + cardMargin, width: cardW, height: cardH))
        scrollView.addSubview(card3)
        card3.backgroundImage = #imageLiteral(resourceName: "grBackground")
        //cardContent
        let cardContent3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CardContent")
        card3.shouldPresent(cardContent3, from: self)
        
        //MARK: CardGroupSliding
        let card4 = CardGroupSliding.init(frame: CGRect(x: card3.frame.maxX + cardMargin, y: card3.frame.minY, width: cardW, height: cardH))
        scrollView.addSubview(card4)
        let icons: [UIImage] = [
            
            UIImage(named: "grBackground")!,
            UIImage(named: "background")!,
            UIImage(named: "flappy")!,
            UIImage(named: "flBackground")!,
            UIImage(named: "Icon")!,
            UIImage(named: "mvBackground")!
            
        ]
        
        card4.icons = icons
        //cardContent
        let cardContent4 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CardContent")
        card4.shouldPresent(cardContent4, from: self)
        
        //MARK: CardArticle
        let card5 = CardGroup.init(frame: CGRect(x: card3.frame.minX, y: card3.frame.maxY + cardMargin, width: cardW, height: cardH))
        scrollView.addSubview(card5)
        card5.backgroundImage = #imageLiteral(resourceName: "grBackground")
        //cardContent
        let cardContent5 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CardContent")
        card5.shouldPresent(cardContent5, from: self)
        
        //MARK: Card
        let card6 = CardGroup.init(frame: CGRect(x: card5.frame.maxX + cardMargin, y: card5.frame.minY, width: cardW, height: cardH))
        scrollView.addSubview(card6)
        card6.title = "This is Title"
        card6.hasParallax = false
        card6.subtitle = "This is subtitle"
        card6.backgroundColor = UIColor.green
        if #available(iOS 10.0, *) {
            card6.blurEffect = .prominent
        } else {
            // Fallback on earlier versions
            card6.blurEffect = .dark
        }
        //cardContent
        let cardContent6 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CardContent")
        card6.shouldPresent(cardContent6, from: self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
