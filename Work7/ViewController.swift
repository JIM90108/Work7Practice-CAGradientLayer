//
//  ViewController.swift
//  Work7
//
//  Created by 彭有駿 on 2022/3/27.
//

import UIKit
import AVFoundation
import SpriteKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var DaySegment: UISegmentedControl!
    
    @IBOutlet weak var DayPage: UIPageControl!
    
    @IBOutlet weak var DearScroll: UIScrollView!
    
    
    //設置參數方便切換照片
    var current = 0
    
    var looper : AVPlayerLooper?
    
    //生成 AVQueuePlayer 物件。
    let player = AVQueuePlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        backgroundMusic()
        DUIBezierPat()
        drawDay1()
        
        
        
    }
    //音樂
    func backgroundMusic(){
        //播放音樂
        let fileUrl = Bundle.main.url(forResource: "music", withExtension: "mp4")!
        //利用 AVPlayerItem 生成要播放的音樂。
        let palyerItem = AVPlayerItem(url: fileUrl)
        
        //生成 AVPlayerLooper，傳入剛剛生成的 player & item。到時候 AVPlayerLooper 將讓 item 重覆播放。
        looper = AVPlayerLooper(player: player, templateItem: palyerItem)
        player.replaceCurrentItem(with: palyerItem)
        player.play()
        
    }
    
    
    
    
    
    //背景
    func setBackground(){
        //skView 雪花
        let skView = SKView(frame: self.view.bounds)
        self.view.insertSubview(skView, at: 0)

        let scene = SKScene(size: skView.frame.size)
        scene.anchorPoint = CGPoint(x: 0.5, y: 1)
        scene.backgroundColor = UIColor.init(red: 112/255, green: 128/255, blue: 144/255, alpha: 1)

        let emitterNode = SKEffectNode(fileNamed: "MyDearParticle")
        scene.addChild(emitterNode!)
        skView.presentScene(scene)

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds  //讓漸層的大小等於 controller view 的大小
        
        gradientLayer.colors = [CGColor(srgbRed: 1, green: 1, blue: 1, alpha: 0),
            CGColor(srgbRed: 1, green: 1, blue: 1, alpha: 1)]//背景顏色

        //疊加在skView上
        skView.layer.addSublayer(gradientLayer)
        
        
        
        //V2
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = view.bounds
//        gradientLayer.colors = [
//           CGColor(srgbRed: 1, green: 0, blue: 0, alpha: 1),
//           CGColor(srgbRed: 0, green: 0, blue: 1, alpha: 1)
//        ]
//        view.layer.insertSublayer(gradientLayer, at: 0)
//
//
//
//        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
//        let snowEmitterCell = CAEmitterCell()
//        snowEmitterCell.contents = UIImage(named: "snowflake")?.cgImage
//        snowEmitterCell.birthRate = 5//控制下雪的數量
//        snowEmitterCell.lifetime = 20//控制下雪的時間
//        snowEmitterCell.scale = 0.1//控制雪花的大小
//        snowEmitterCell.scaleRange = 0.1
//        snowEmitterCell.velocity = 100//控制雪花維持的時間
//        snowEmitterCell.yAcceleration = 50//控制雪花向下的移動速度
//        snowEmitterCell.scaleSpeed = -0.02
//
//
//        let snowEmitterLayer = CAEmitterLayer()//雪花的移動速度
//
//        snowEmitterLayer.emitterCells = [snowEmitterCell]
//        snowEmitterLayer.emitterPosition = CGPoint(x: view.bounds.width / 2, y: -50)
//        snowEmitterLayer.emitterSize = CGSize(width: view.bounds.width, height: 0)
//        snowEmitterLayer.emitterShape = .line
//
//        view.layer.addSublayer(snowEmitterLayer)
    }
    
    
    
    //Segment邏輯
    @IBAction func drawDaySegment(_ sender: UISegmentedControl) {
        current = DaySegment.selectedSegmentIndex
        DayPage.currentPage = current
        DearScroll.contentOffset.x = CGFloat(current*414)
        if sender.selectedSegmentIndex == 0 {
            DUIBezierPat()
            drawDay1()
            D2checkmarkLayer.removeFromSuperlayer()
//            DearScroll.contentOffset.x = CGFloat(current*414)
        }else{
//            DearScroll.contentOffset.x = CGFloat(current*414)
            DUIBezierPat()
            D1checkmarkLayer.removeFromSuperlayer()
            drawDay2()
        }
    }
    
    
    //Page邏輯
    @IBAction func drawDayPage(_ sender: UIPageControl) {
        current = sender.currentPage
        DaySegment.selectedSegmentIndex = current
        DayPage.currentPage = current
        DearScroll.contentOffset.x = CGFloat(current*414)
        if current == 0 {
            DUIBezierPat()
            drawDay1()
            D2checkmarkLayer.removeFromSuperlayer()
            DearScroll.contentOffset.x = CGFloat(current*414)
        } else{
            DearScroll.contentOffset.x = CGFloat(current*414)
            DUIBezierPat()
            D1checkmarkLayer.removeFromSuperlayer()
            drawDay2()
        }
    }
    
    
    
    
    
    
    let DcheckmarkLayer = CAShapeLayer()
    let checkmarkLayer = CAShapeLayer()
    func DUIBezierPat(){
        //畫D旁的|
        let Dpath = UIBezierPath()
        var Dpoint = CGPoint(x: 160, y: 527.5)
        Dpath.move(to: Dpoint)
        Dpoint = CGPoint(x: 160, y: 612.6)
        Dpath.addLine(to: Dpoint)
        DcheckmarkLayer.path = Dpath.cgPath
        DcheckmarkLayer.lineWidth = 5
        DcheckmarkLayer.strokeColor = UIColor.black.cgColor
        DcheckmarkLayer.fillColor = nil
        view.layer.addSublayer(DcheckmarkLayer)
        let Danimation = CABasicAnimation(keyPath: "strokeEnd")
        Danimation.fromValue = 0 //控制動畫開始
        Danimation.toValue = 1 //控制動畫結束
        Danimation.duration = 5 //控制動畫時間
        DcheckmarkLayer.add(Danimation, forKey: nil)
        
        //畫D旁的半圓
        let aDegree = CGFloat.pi / 180
        let path = UIBezierPath(arcCenter: CGPoint(x: 160, y: 570), radius: 40, startAngle: aDegree * 270, endAngle: aDegree * 90, clockwise: true)
        checkmarkLayer.path = path.cgPath
        checkmarkLayer.lineWidth = 5
        checkmarkLayer.strokeColor = UIColor.black.cgColor
        checkmarkLayer.fillColor = nil
        view.layer.addSublayer(checkmarkLayer)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 5
        checkmarkLayer.add(animation, forKey: nil)
    }
    
    
    //畫數字1
    let D1checkmarkLayer = CAShapeLayer()
    func drawDay1(){
        let path = UIBezierPath()
        var point = CGPoint(x: 220, y: 527.5)
        path.move(to: point)
        point = CGPoint(x: 220, y: 612.6)
        path.addLine(to: point)
        D1checkmarkLayer.path = path.cgPath
        D1checkmarkLayer.lineWidth = 5
        D1checkmarkLayer.strokeColor = UIColor.black.cgColor
        D1checkmarkLayer.fillColor = nil
        view.layer.addSublayer(D1checkmarkLayer)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 5
        D1checkmarkLayer.add(animation, forKey: nil)
    }
    
    //畫數字2
    let D2checkmarkLayer = CAShapeLayer()
    func drawDay2(){
        let path = UIBezierPath()
        var point = CGPoint(x: 215, y: 527.5)
        path.move(to: point)
        point = CGPoint(x: 250, y: 527.5)
        path.addLine(to: point)
        point = CGPoint(x: 250, y: 570)
        path.addLine(to: point)
        point = CGPoint(x: 215, y: 570)
        path.addLine(to: point)
        point = CGPoint(x: 215, y: 612.6)
        path.addLine(to: point)
        point = CGPoint(x: 250, y: 612.6)
        path.addLine(to: point)
        D2checkmarkLayer.path = path.cgPath
        D2checkmarkLayer.lineWidth = 5
        D2checkmarkLayer.strokeColor = UIColor.black.cgColor
        D2checkmarkLayer.fillColor = nil
        view.layer.addSublayer(D2checkmarkLayer)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 5
        D2checkmarkLayer.add(animation, forKey: nil)
    }
    
    
    


}

