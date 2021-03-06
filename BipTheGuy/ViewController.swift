//
//  ViewController.swift
//  BipTheGuy
//
//  Created by Lazaro Alvelaez on 9/19/20.
//  Copyright © 2020 Lazaro Alvelaez. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var audioPlayer: AVAudioPlayer!
    var imagePickerController = UIImagePickerController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePickerController.delegate = self
    }
    
    func playSound(new : String) {
        if let sound = NSDataAsset(name: new) {
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                print("ERROR: \(error.localizedDescription) Could not read data file sound0")
            }
            
        } else {
            print("Could not read data file sound0")
        }
    }
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        playSound(new: "punchSound")
        let originalImageFrame = imageView.frame
        let imageWidthShrink: CGFloat = 20
        let imageHeightShrink: CGFloat = 20
        let imageSmallerRect = CGRect(x: imageView.frame.origin.x + imageWidthShrink,
                                        y: imageView.frame.origin.y + imageHeightShrink,
                                        width: imageView.frame.width - (2 * imageWidthShrink),
                                        height: imageView.frame.height - (2 * imageHeightShrink))
               
               imageView.frame = imageSmallerRect
               UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10.0, animations: {
                   self.imageView.frame = originalImageFrame
               })
    }
    
    func showAlert(title : String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK!", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)

    }
    
    @IBAction func photoOnCamaraPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (_) in
            self.accessPhotoLibrary()
        }
        let camaraAction = UIAlertAction(title: "Camara", style: .default) { (_) in
            self.accessCamara()
        }
            
            
        let cancelAction = UIAlertAction(title: "Cance", style: .cancel, handler: nil)
            
        alertController.addAction(photoLibraryAction)
        alertController.addAction(camaraAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)

            


        }
    
}
    
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageView.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = originalImage

        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func accessCamara() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
        } else {
            showAlert(title: "Camara Not Available", message: "There Is No Camara On This Device")
        }
        
    }
    
    func accessPhotoLibrary() {
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
}


