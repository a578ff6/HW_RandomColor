//
//  ViewController.swift
//  HW_RandomColor
//
//  Created by 曹家瑋 on 2023/5/5.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bartImageView: UIImageView!
    @IBOutlet weak var patternImageView: UIImageView!
  
    @IBOutlet weak var pantsView: UIView!
    
    @IBOutlet weak var clothesRedSlider: UISlider!
    @IBOutlet weak var clothesBlueSlider: UISlider!
    @IBOutlet weak var clothesGreenSlider: UISlider!
    @IBOutlet weak var clothesAlphaSlider: UISlider!
    
    @IBOutlet weak var pantsRedSlider: UISlider!
    @IBOutlet weak var pantsBlueSlider: UISlider!
    @IBOutlet weak var pantsGreenSlider: UISlider!
    @IBOutlet weak var pantsAlphaSlider: UISlider!
    
    @IBOutlet weak var clothesRedValueLabel: UILabel!
    @IBOutlet weak var clothesBlueValueLabel: UILabel!
    @IBOutlet weak var clothesGreenValueLabel: UILabel!
    @IBOutlet weak var clothesAlphaValueLabel: UILabel!
    
    @IBOutlet weak var pantsRedValueLabel: UILabel!
    @IBOutlet weak var pantsBlueValueLabel: UILabel!
    @IBOutlet weak var pantsGreenValueLabel: UILabel!
    @IBOutlet weak var pantsAlphaValueLabel: UILabel!
    
    @IBOutlet weak var cornerRadiusSlider: UISlider!
    @IBOutlet weak var cornerRadiusValueLabel: UILabel!
    @IBOutlet weak var cornerRadiusSwitch: UISwitch!
    
    @IBOutlet weak var clothPantsScrollview: UIScrollView!
    
    // Pattern紋路
    let patterns = ["flowerBackGround", "PlaidBackGround", "camouflageBackGround"]
    var index = 0
    
    // 宣告數值，用以數字字串轉換(由於寫法的關係，這行程式碼可以取消）
//    var valueClothesRed = 0
//    var valueBlue = 0
//    var valueGreen = 0
//    var valueAlpha = 0
//    var valueCornerRadius = 0
    
//    var valuePantsRed = 0
//    var valuePantsBlue = 0
//    var valuePantsGreen = 0
//    var valuePantsAlpha = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Label 數值字串預設
        clothesRedValueLabel.text = "255"
        clothesBlueValueLabel.text = "255"
        clothesGreenValueLabel.text = "255"
        clothesAlphaValueLabel.text = "1.00"
        cornerRadiusValueLabel.text = "30"
        
        pantsRedValueLabel.text = "255"
        pantsBlueValueLabel.text = "255"
        pantsGreenValueLabel.text = "255"
        pantsAlphaValueLabel.text = "1.00"
        
        // ImageView 預設值
        bartImageView.layer.cornerRadius = 30
        patternImageView.layer.cornerRadius = 30
        
        // Switch 預設值
        cornerRadiusSwitch.isOn = false
        cornerRadiusSlider.isEnabled = false
        
        // 褲子View著色 Mask
        let pantsImage = UIImage(named: "pants")
        let pantsImageView = UIImageView(image: pantsImage)
        // 與 pnatsView 的 bounds 相同大小
        pantsImageView.frame = pantsView.bounds
        pantsImageView.contentMode = .scaleAspectFill
        pantsView.mask = pantsImageView
        
        // 初始化褲子顏色，與褲子Slider一致
        updatedPantsColor()
        
    }
    
    // 衣服Slider
    @IBAction func changeClothesColorSlider(_ sender: Any) {
        
        updatedClothesColor()
        
//        錯誤
//        updatedPantsColor()

//        print(clothesRedSlider.value)
 
    }
    
    // 褲子Slider
    @IBAction func changePantsColorSlider(_ sender: Any) {
        
        updatedPantsColor()
        
    }
    
    // 衣服隨機Button
    @IBAction func randomClothesButton(_ sender: Any) {
        
        clothesRedSlider.setValue(Float.random(in: 0...255), animated: true)
        clothesBlueSlider.setValue(Float.random(in: 0...255), animated: true)
        clothesGreenSlider.setValue(Float.random(in: 0...255), animated: true)
        clothesAlphaSlider.setValue(Float.random(in: 0...1), animated: true)
        
        // 要注意執行順序
        updatedClothesColor()

    }
    
    // 衣服重置Button
    @IBAction func resetClothesButton(_ sender: Any) {
        
        clothesRedSlider.value = 255
        clothesBlueSlider.value = 255
        clothesGreenSlider.value = 255
        clothesAlphaSlider.value = 1
        
        updatedClothesColor()
        
    }
    
    // 背景圓角 （User Interaction Enabled 要true)
    @IBAction func cornerRadiusSliderChanged(_ sender: Any) {
        bartImageView.layer.cornerRadius = CGFloat(cornerRadiusSlider.value)
        patternImageView.layer.cornerRadius = CGFloat(cornerRadiusSlider.value)
        
        // Label數字轉字串
        cornerRadiusValueLabel.text = String(Int(cornerRadiusSlider.value))
//        valueCornerRadius = Int(cornerRadiusSlider.value)
//        cornerRadiusValueLabel.text = String(valueCornerRadius)
        
    }
    
    // 圓角 Switch 開關
    @IBAction func cornerRadiusSwitchValueChanged(_ sender: UISwitch) {
        // 開啟的狀態是啟用
        if sender.isOn {
            cornerRadiusSlider.isEnabled = true
        } else {
            cornerRadiusSlider.isEnabled = false

        }
    }
    
    // 褲子隨機 Button
    @IBAction func randomPantsButton(_ sender: Any) {
        
        pantsRedSlider.setValue(Float.random(in: 0...255), animated: true)
        pantsBlueSlider.setValue(Float.random(in: 0...255), animated: true)
        pantsGreenSlider.setValue(Float.random(in: 0...255), animated: true)
        pantsAlphaSlider.setValue(Float.random(in: 0...1), animated: true)

        updatedPantsColor()
    }
    
    // 褲子重置 Button
    @IBAction func restPantsButton(_ sender: Any) {
        
        pantsRedSlider.value = 255
        pantsBlueSlider.value = 255
        pantsGreenSlider.value = 255
        pantsAlphaSlider.value = 1
        
        updatedPantsColor()
        
    }
    
    
    @IBAction func ClothesPatternSegmentedControl(_ sender: UISegmentedControl) {
        index = sender.selectedSegmentIndex
        let patternName = patterns[index]
        
        patternImageView.image = UIImage(named: patternName)
    }
    
    
    // 衣服更新圖片顏色和顯示 Slider 值的 Label。
    func updatedClothesColor() {
        // 數字轉字串
        clothesRedValueLabel.text = String(Int(clothesRedSlider.value))
        clothesBlueValueLabel.text = String(Int(clothesBlueSlider.value))
        clothesGreenValueLabel.text = String(Int(clothesGreenSlider.value))
        clothesAlphaValueLabel.text = String(format: "%.2f", clothesAlphaSlider.value)
        
        // Slider 數值調整
        bartImageView.backgroundColor = UIColor(red: CGFloat(clothesRedSlider.value/255), green: CGFloat(clothesGreenSlider.value/255), blue: CGFloat(clothesBlueSlider.value/255), alpha: CGFloat(clothesAlphaSlider.value))
    }
    
    // 褲子更新圖片顏色和顯示 Slider 值的 Label。
    func updatedPantsColor() {
        pantsRedValueLabel.text = String(Int(pantsRedSlider.value))
        pantsBlueValueLabel.text = String(Int(pantsBlueSlider.value))
        pantsGreenValueLabel.text = String(Int(pantsGreenSlider.value))
        pantsAlphaValueLabel.text = String(format: "%.2f", pantsAlphaSlider.value)

        pantsView.backgroundColor = UIColor(red: CGFloat(pantsRedSlider.value/255), green: CGFloat(pantsGreenSlider.value/255), blue: CGFloat(pantsBlueSlider.value/255), alpha: CGFloat(pantsAlphaSlider.value))
    }
    
    
}

