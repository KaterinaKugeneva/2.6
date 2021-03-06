import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
   
    @IBOutlet weak var redField: UITextField!
    @IBOutlet weak var greenField: UITextField!
    @IBOutlet weak var blueField: UITextField!
    
    var backGroundColor: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 15
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        
        redField.delegate = self
        greenField.delegate = self
        blueField.delegate = self
    
        colorView.backgroundColor = backGroundColor
        if let myColorComponents = backGroundColor.components {
            
            redSlider.value = Float(myColorComponents.red)
            greenSlider.value = Float(myColorComponents.green)
            blueSlider.value = Float(myColorComponents.blue)
            
        }
       
        
        redLabel.text = String(format: "%.2f",redSlider.value)
        greenLabel.text = String(format: "%.2f", greenSlider.value)
        blueLabel.text = String(format: "%.2f", blueSlider.value)
        
        redField.text = String(format: "%.2f", redSlider.value)
        greenField.text = String(format: "%.2f", greenSlider.value)
        blueField.text = String(format: "%.2f", blueSlider.value)
        
        
    }
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    // Изменение цветов слайдерами
    @IBAction func rgbSlider(_ sender: UISlider) {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
        
        redLabel.text = String(format: "%.2f", redSlider.value)
        greenLabel.text = String(format: "%.2f", greenSlider.value)
        blueLabel.text = String(format: "%.2f", blueSlider.value)
        
        redField.text = String(format: "%.2f", redSlider.value)
        greenField.text = String(format: "%.2f", greenSlider.value)
        blueField.text = String(format: "%.2f", blueSlider.value)
                
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let numberValue = Double(newValue) else {
            textField.text = "0"
            return }
        if Double(textField.text!)! < 0 || Double(textField.text!)! < 0 {
            showAlert(tittle: "Error", message: "Wrong input values")
        } else
        {
        
        redSlider.value = (redField.text! as NSString).floatValue
        greenSlider.value = (greenField.text! as NSString).floatValue
        blueSlider.value = (blueField.text! as NSString).floatValue
        
        redLabel.text = redField.text
        greenLabel.text = greenField.text
        blueLabel.text = blueField.text
        
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
        }
       
    }
    

   /* if  textUsername.text  != username || textPassword.text != password {
                showAlert(tittle: "Error", message: "Wrong username or password")
            } else{
                self.performSegue(withIdentifier: "segueFromAtoB", sender: self)
            }
        }
    
    */
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        delegate?.setColor(colorView.backgroundColor!)
        dismiss(animated: true)
    }
}
extension UIColor {
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        return getRed(&r, green: &g, blue: &b, alpha: &a) ? (r,g,b,a) : nil
    }
}
extension ViewController {
    func showAlert (tittle: String, message:String) {
        let alert = UIAlertController(title: tittle, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present (alert , animated: true )
        
    }
}
