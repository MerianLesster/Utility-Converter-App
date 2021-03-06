//
//  CustomKeyboard.swift
//  Utility Converter App
//
//  Created by Damian Ranjit on 2021-03-17.
//

import UIKit

// constant which holds the defualt keyboard height
let customKeyboardHeight = 280.00

// constants that hold button colors
private let defaultKeyColour = UIColor(red: 30 / 255, green: 30 / 255, blue: 30 / 255, alpha: 1.00)
private let pressedKeyColour = UIColor(red: 50 / 255, green: 50 / 255, blue: 50 / 255, alpha: 1.00)

// Optional Protocol to be called
// External data source for theCustomKeyboard class to communicate with VC
@objc protocol CustomKeyboardDelegate {
    func numericKeyPressed(key: Int)
    func backspacePressed()
    func symbolPressed(symbol: String)
    func hideKeyboardPressed()
}

class CustomKeyboard: UIView {

    // MARK: - Outlet connections of the custom keyboard UI elements
    
    // Outlets of controller buttons (hide,backspace)
    @IBOutlet var btnHideKeyboard: UIButton!
    @IBOutlet var btnBackspace: UIButton!
    
    // Outlets of the numeric buttons
    @IBOutlet var btnNKey0: UIButton!
    @IBOutlet var btnNKey1: UIButton!
    @IBOutlet var btnNKey2: UIButton!
    @IBOutlet var btnNKey3: UIButton!
    @IBOutlet var btnNKey4: UIButton!
    @IBOutlet var btnNKey5: UIButton!
    @IBOutlet var btnNKey6: UIButton!
    @IBOutlet var btnNKey7: UIButton!
    @IBOutlet var btnNKey8: UIButton!
    @IBOutlet var btnNKey9: UIButton!
    
    // Outlets of the symbolic buttons
    @IBOutlet var btnSKeyMinus: UIButton!
    @IBOutlet var btnSKeyPeriod: UIButton!
    
    // Number pad buttons to change the apperance
    var allButtons: [UIButton] { return [btnNKey0, btnNKey1, btnNKey2, btnNKey3, btnNKey4, btnNKey5, btnNKey6, btnNKey7, btnNKey8, btnNKey9, btnSKeyMinus, btnSKeyPeriod] }
    
    // Vairables that set the appearence of the buttins
    var btnBgColor = defaultKeyColour { didSet { changeBtnAppearance() } }
    var btnPressedBgColor = pressedKeyColour { didSet { changeBtnAppearance() } }
    var btnFontColor = UIColor.systemBlue { didSet { changeBtnAppearance() } }
    var btnPressedFontColor = UIColor.gray { didSet { changeBtnAppearance() } }
    
    // Keyboard - vController connection variables
    weak var delegate: CustomKeyboardDelegate?
    
    // MARK: - Initialization of the custom keyboard
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeKeyboard()
        NotificationCenter.default.addObserver(self, selector: #selector(activateMinusButton(notification:)), name: NSNotification.Name(rawValue: "activateMinusButton"), object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeKeyboard()
    }
    
    func initializeKeyboard() {
        let xibFileName = "CustomKeyboard"
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)![0] as! UIView
        addSubview(view)
        view.frame = bounds
    }
    
    // MARK: - Functions to handle button clicks
    
    // Triggers for numeric button (0-9) clicks
    @IBAction func handleNumericBtnClick(_ sender: UIButton) {
        delegate?.numericKeyPressed(key: sender.tag)
    }
    
    // Triggers for symbolic button (period and minus) clicks
    @IBAction func handleSymbolicBtnClick(_ sender: UIButton) {
        if let symbol = sender.titleLabel?.text, symbol.count > 0 {
            delegate?.symbolPressed(symbol: symbol)
        }
    }
    
    // Triggers for backspace button click
    @IBAction func handleBackspaceBtnClick(_ sender: Any) {
        delegate?.backspacePressed()
    }
    
    // Triggers for hide keyboard layout button click
    @IBAction func handleHideKeyboardBtnClick(_ sender: Any) {
        delegate?.hideKeyboardPressed()
    }
    
    // Button Activator Functions
    @objc func activateMinusButton(notification: NSNotification) {
        btnSKeyMinus.isUserInteractionEnabled = true
    }
    
    // Funtion to update button appearance based on button state
    fileprivate func changeBtnAppearance() {
        for keyboardButton in allButtons {
            keyboardButton.setTitleColor(btnFontColor, for: .normal)
            keyboardButton.setTitleColor(btnPressedFontColor, for: [.selected, .highlighted])
            // TODO: Use a condition to change the background color of the button based on the states
        }
    }
}
