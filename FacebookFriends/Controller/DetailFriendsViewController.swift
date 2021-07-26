//
//  DetailFriendsViewController.swift
//  FacebookFriends
//
//  Created by Burhan Alışkan on 24.07.2021.
//

import UIKit

class DetailFriendsViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var fullNameTextField: UITextField?
    @IBOutlet weak var genderTextField: UITextField?
    @IBOutlet weak var locationTextField: UITextField?
    @IBOutlet weak var emailTextField: UITextField?
    @IBOutlet weak var birthDateTextField: UITextField?
    @IBOutlet weak var ageTextField: UITextField?
    @IBOutlet weak var phoneTextField: UITextField?
    @IBOutlet weak var nationalityTextField: UITextField?
    
    var name: String?
    var gender: String?
    var location: String?
    var email: String?
    var birthDate: String?
    var age: Int?
    var phone: String?
    var nationality: String?
    var imageLink: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        editObject()
    }
    
    //MARK: - ImageView Design
    func editImageView(_ image: UIImageView) {
        let myColor = #colorLiteral(red: 0.6203528643, green: 0.7731217146, blue: 0.6885442138, alpha: 1)

        image.layer.cornerRadius = 30
        image.layer.shadowColor = myColor.cgColor
        image.layer.shadowRadius = 10.0
        image.layer.shadowOpacity = 0.1
        image.clipsToBounds = true
    }
    
    //MARK: - TextField Design
    func editTextField(_ textField: UITextField) {
        let myColor = #colorLiteral(red: 0.6203528643, green: 0.7731217146, blue: 0.6885442138, alpha: 1)

        textField.layer.cornerRadius = 15
        textField.layer.shadowColor = myColor.cgColor
        textField.layer.shadowRadius = 10.0
        textField.layer.shadowOpacity = 0.1
        textField.layer.borderWidth = 1
        textField.layer.borderColor = myColor.cgColor
        textField.clipsToBounds = true
    }
    
    //MARK: - Set IBOutlet
    func configure() {
        getImage(imageLink!)
        fullNameTextField?.text = name
        genderTextField?.text = gender
        locationTextField?.text = location
        emailTextField?.text = email
        birthDateTextField?.text = birthDate
        ageTextField?.text = String(age!)
        phoneTextField?.text = phone
        nationalityTextField?.font = nationalityTextField?.font!.withSize(40)
        nationalityTextField?.text = getCountryFlag(countryCode: nationality!)
    }
    
    //MARK: - Editing
    func editObject() {
        editImageView(imageView!)
        editTextField(fullNameTextField!)
        editTextField(genderTextField!)
        editTextField(locationTextField!)
        editTextField(emailTextField!)
        editTextField(birthDateTextField!)
        editTextField(ageTextField!)
        editTextField(phoneTextField!)
    }
        
    //MARK: - GetImage
    func getImage(_ imageLink: String)  {
        guard let url = URL(string: imageLink) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                let image = self.resizeImage(image: UIImage(data: data)!, targetSize: CGSize(width: 200, height: 200))

                self.imageView?.image = image
            }
        }
        task.resume()
    }
    
    //MARK: - GetCountry
    func getCountryFlag(countryCode: String) -> String {
      let base = 127397
      var tempScalarView = String.UnicodeScalarView()
      for i in countryCode.utf16 {
        if let scalar = UnicodeScalar(base + Int(i)) {
          tempScalarView.append(scalar)
        }
      }
      return String(tempScalarView)
    }
    
    
    //MARK: - Resize Image
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
       let size = image.size
       
       let widthRatio  = targetSize.width  / size.width
       let heightRatio = targetSize.height / size.height
       
       // Figure out what our orientation is, and use that to form the rectangle
       var newSize: CGSize
       if(widthRatio > heightRatio) {
           newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
       } else {
           newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
       }
       
       // This is the rect that we've calculated out and this is what is actually used below
       let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
       
       // Actually do the resizing to the rect using the ImageContext stuff
       UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
       image.draw(in: rect)
       let newImage = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()
       
       return newImage!
   }
    
}
