//
//  DistortionViewController.swift
//

import UIKit
import CoreImage

class DistortionViewController: UIViewController {

  @IBOutlet var instructionsLabel: UILabel!
  @IBOutlet var displayView: UIImageView!

  var image: CIImage?

  override func viewDidLoad() {
    super.viewDidLoad()


    let imageURL = Bundle.main.url(forResource: "dog_portrait", withExtension: "HEIC")!
    image =  CIImage(contentsOf: imageURL, options: [CIImageOption.applyOrientationProperty: true])

    loadCleanImage()

  }

  fileprivate func loadCleanImage() {
    guard let image = image else { return }
    displayView.image = UIImage.init(ciImage: image)
    instructionsLabel.isHidden = false
  }

  fileprivate func distort(center: CIVector) {
    let filter = HoleDistortionFilter()
    filter.inputImage = image
    filter.inputCenter = center

    displayView.image = UIImage(ciImage: (filter.outputImage) ?? CIImage())
  }

  @IBAction func resetTapped(_ sender: Any) {
    loadCleanImage()
  }


  @IBAction func touchDragged(_ sender: UIPanGestureRecognizer) {
    instructionsLabel.isHidden = true
    let touch = sender.location(in: sender.view)

    let x = touch.x  / sender.view!.bounds.width
    let y = touch.y / sender.view!.bounds.height

    distort(center: CIVector(x: CGFloat(x), y: CGFloat(y)))
  }
}

