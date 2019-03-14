//
//  ViewController.swift
//  AZNavigationBar
//
//  Created by cocozzhang on 2019/3/11.
//  Copyright © 2019 cocozzhang. All rights reserved.
//

import UIKit
import Foundation


class ViewController: UIViewController {
    var titleView:UIView?
    var leftView:UIView?
    var rightView:UIView?
    let Accuracy = "%.1f" //精度
    var centerLabel:UILabel?

    @IBOutlet weak var titleWidthLabel: UILabel!
    @IBOutlet weak var titleWidthSlider: UISlider!
    @IBOutlet weak var leftWidthLabel: UILabel!
    @IBOutlet weak var leftWidthSlider: UISlider!
    @IBOutlet weak var rightWidthLabel: UILabel!
    @IBOutlet weak var rightWidthSlider: UISlider!
    
    @IBOutlet weak var titleItemLeft: UILabel!
    @IBOutlet weak var titleItemWidth: UILabel!
    @IBOutlet weak var titleItemRight: UILabel!
    @IBOutlet weak var leftItemLeft: UILabel!
    @IBOutlet weak var leftItemWidth: UILabel!
    @IBOutlet weak var leftItemRight: UILabel!
    @IBOutlet weak var rightItemLeft: UILabel!
    @IBOutlet weak var rightItemWidth: UILabel!
    @IBOutlet weak var rightItemRight: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleView = createTitleView()
        self.navigationItem.titleView = titleView
        leftView = createLeftView()
        let leftItem = UIBarButtonItem.init(customView: leftView!)
        self.navigationItem.leftBarButtonItem = leftItem
        rightView = createRightView()
        let rightItem = UIBarButtonItem.init(customView: rightView!)
        self.navigationItem.rightBarButtonItem = rightItem
        
        setTiltleWidthLabel(width: SizeManager.shared.titleWidth)
        setLeftWidthLabel(width: SizeManager.shared.leftWidth)
        leftWidthSlider.value = Float(SizeManager.shared.leftWidth/self.view.bounds.width)
        setRightWidthLabel(width: SizeManager.shared.rightWidth)
        rightWidthSlider.value = Float(SizeManager.shared.rightWidth/self.view.bounds.width)
        
        DispatchQueue.main.asyncAfter(deadline:.now() + .milliseconds(50)) {
            self.updateLeftItem()
            self.updateTitleItem()
            self.updateRightItem()
        }
    }

    @IBAction func onPushClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController")
        self.navigationController?.pushViewController(vc!, animated: true);
        
    }
    
    /**center*/
    func createTitleView() -> UIView {
        let titleView = UIView.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: Int(SizeManager.shared.titleWidth), height: 64)))
        titleView.backgroundColor = UIColor.init(displayP3Red: 0.9, green: 0.8, blue: 0.7, alpha: 0.6)

        let title = UILabel.init()
        title.text = "center center center"
        title.sizeToFit()
        title.backgroundColor = UIColor.init(displayP3Red: 1, green: 0.8, blue: 0.9, alpha: 1)
        centerLabel = title
//        centerLabel?.frame.size.width = CGFloat(SizeManager.shared.titleLabelWidth)
        centerLabel?.frame.origin.x = SizeManager.shared.titleLabelLeft
        
        titleView.addSubview(title)
        return titleView;
    }
    
    @IBAction func onChangeTitleWidth(_ sender: Any) {
        let slider:UISlider = sender as! UISlider
        let width = self.view.bounds.width
        let newWidth = CGFloat(slider.value) * width
        
        setTiltleWidthLabel(width:newWidth)
    }
    
    func setTiltleWidthLabel(width: CGFloat) -> Void {
        titleView?.frame.size.width = CGFloat(width)
        titleWidthLabel.text = String(format: Accuracy, width)
        SizeManager.shared.titleWidth = width
        
        titleWidthSlider.value = Float(width/self.view.bounds.width)
        
        updateNatigationBarItems()
    }
    
    func updateTitleItem() -> Void {
        let titleSuperView = titleView?.superview
        let left = titleSuperView?.frame.minX ?? 0
        let width = titleSuperView?.frame.width ?? 0
        let right = self.view.bounds.width - left - width
        
        titleItemLeft.text = String(format: Accuracy, left )
        titleItemWidth.text = String(format: Accuracy, width )
        titleItemRight.text = String(format: Accuracy, right )
    }
    
    /**left*/
    func createLeftView() -> UIView {
        let leftView = UIView.init(frame: CGRect(origin: CGPoint.zero, size: CGSize.init(width:Int(SizeManager.shared.leftWidth), height: 40)))
        leftView.backgroundColor = UIColor.init(red: 0.6, green: 0.8, blue: 0.43, alpha: 0.6)
        
        let left = UILabel.init(frame: CGRect(x: -20, y: 0, width: 0, height: 0))
        left.text = "< left"
        left.sizeToFit()
        left.backgroundColor = UIColor.init(displayP3Red: 0.1, green: 0.8, blue: 0.9, alpha: 1)
        
        
        leftView.addSubview(left)
        return leftView
    }
    
    @IBAction func onChangeLeftWidth(_ sender: Any) {
        let slider:UISlider = sender as! UISlider
        let width = self.view.bounds.width
        let newWidth = CGFloat(slider.value) * width
        
        setLeftWidthLabel(width: newWidth)
    }
    
    func setLeftWidthLabel(width: CGFloat) -> Void {
        leftView?.frame.size.width = CGFloat(width)
        leftWidthLabel.text = String(format: Accuracy, width)
        SizeManager.shared.leftWidth = width
        
        updateNatigationBarItems()
    }
    
    func updateLeftItem() {
        let leftSuperView = leftView?.superview?.superview
        let left = leftSuperView?.frame.minX ?? 0
        let width = leftSuperView?.frame.width ?? 0
        let right = self.view.bounds.width - left - width
        
        leftItemLeft.text = String(format: Accuracy, left)
        leftItemWidth.text = String(format: Accuracy, width)
        leftItemRight.text = String(format: Accuracy, right)
    }
    
    /**right*/
    func createRightView() -> UIView {
        let rightView = UIView.init(frame: CGRect(origin: CGPoint.zero, size: CGSize.init(width:Int(SizeManager.shared.rightWidth), height: 40)))
        rightView.backgroundColor = UIColor.init(red: 0.46, green: 0.18, blue: 0.83, alpha: 0.6)
        
        let label = UILabel.init()
        label.text = "right >"
        label.sizeToFit()
        label.backgroundColor = UIColor.init(displayP3Red: 0.1, green: 0.8, blue: 0.9, alpha: 1)
        
        
        rightView.addSubview(label)
        return rightView
    }
    
    @IBAction func onChangeRightWidth(_ sender: Any) {
        let slider:UISlider = sender as! UISlider
        let width = self.view.bounds.width
        let newWidth = CGFloat(slider.value) * width
        
        setRightWidthLabel(width: newWidth)
    }
    
    func setRightWidthLabel(width: CGFloat) -> Void {
        rightView?.frame.size.width = width
        rightWidthLabel.text = String(format: Accuracy, width)
        SizeManager.shared.rightWidth = width
        
        updateNatigationBarItems()
    }
    
    func updateRightItem() {
        let superView = rightView?.superview?.superview
        let left = superView?.frame.minX ?? 0
        let width = superView?.frame.width ?? 0
        let right = self.view.bounds.width - left - width
        
        rightItemLeft.text = String(format: Accuracy, left)
        rightItemWidth.text = String(format: Accuracy, width)
        rightItemRight.text = String(format: Accuracy, right)
    }
    
    func updateNatigationBarItems() -> Void {
        updateLeftItem()
        updateTitleItem()
        updateRightItem()
        
//        guard leftW != 0 && rightW != 0 else {
//            return
//        }
//        centerLabel?.frame.size.width = self.view.bounds.width - 20.0*2.0 - 6.0*2.0
//        centerLabel?.frame.size.width -= leftW + rightW
//        centerLabel?.frame.origin.x = min(0, leftW - rightW)
//        SizeManager.shared.titleLabelWidth = Float(centerLabel?.frame.size.width ?? 0)
//        SizeManager.shared.titleLabelLeft = centerLabel?.frame.origin.x ?? 0
//
//        let centerW = Float(centerLabel?.frame.size.width ?? 0) - fabsf(Float(leftW - rightW))
//        titleView?.frame.size.width = CGFloat(centerW)
//        titleWidthLabel.text = String(format: Accuracy, centerW)
//        SizeManager.shared.titleWidth = Float(centerW)
//
//        titleWidthSlider.value = Float(centerW)/Float(self.view.bounds.width)
        
    }
}

