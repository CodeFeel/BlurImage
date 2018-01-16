//
//  ViewController.swift
//  LW背景图片的虚化效果
//
//  Created by ios on 2017/10/13.
//  Copyright © 2017年 swiftHPRT. All rights reserved.
//

import UIKit

public let ScreenWidth = UIScreen.main.bounds.size.width
public let ScreenHeight = UIScreen.main.bounds.size.height

class ViewController: UIViewController {

    
    @IBOutlet weak var blurView: UIView!
    
    @IBOutlet weak var textImage: UIImageView!
    
    @IBOutlet weak var tintSlider: UISlider!
    
    @IBOutlet weak var saturationSlider: UISlider!
    
    @IBOutlet weak var blurSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "图片的虚化效果"
        textImage.image = #imageLiteral(resourceName: "pic_14")
        
        blurView.backgroundColor = .white
        tintSlider.value = 0
        saturationSlider.value = 2.5
        blurSlider.value = 8
        setBackGroundColor((Any).self)
        
        
    }
    
    @IBAction func setBackGroundColor(_ sender: Any) {
        let image = #imageLiteral(resourceName: "pic_14")
        
        let scaleImg = image.scale(toHeight: self.blurView.frame.height)
        scaleImg.blurImage(with: .black, colorOpacity: CGFloat(tintSlider.value), saturationDeltaFactor: CGFloat(saturationSlider.value), blurRadius: CGFloat(blurSlider.value), completion: { (blurImage) in
            if let image = blurImage {
                self.blurView.backgroundColor = UIColor.init(patternImage: image)
            }
        })
        
    
    }

}

extension UIImage {
    
    public func scale(toHeight maxHeight: CGFloat) -> UIImage {
        let scale = self.size.width/self.size.height
        let maxWidth = maxHeight * scale
        return self.scale(with: maxWidth, height: maxHeight)
    }
    
    public func scale(with width: CGFloat, height: CGFloat) -> UIImage {
        //1.开启上下文
        UIGraphicsBeginImageContextWithOptions(CGSize.init(width: width, height: height),false, UIScreen.main.scale);
        //2.绘制图片
        self.draw(in: CGRect.init(x: 0, y: 0, width: width, height: height))
        //3.从上下文中获取新图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //4.关闭图形上下文
        UIGraphicsEndImageContext()
        return newImage!
    }
}





