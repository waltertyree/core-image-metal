//
//  ViewController.swift
//  filter-harness
//
//  Created by Walter Tyree on 8/5/21.
//

import UIKit
import CoreImage

class ViewController: UIViewController {


  @IBOutlet var filterSlider: UISlider!
  @IBOutlet var displayView: UIImageView!

  var image: CIImage?

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.


    let imageURL = Bundle.main.url(forResource: "dog_portrait", withExtension: "HEIC")!
    image =  CIImage(contentsOf: imageURL, options: [CIImageOption.applyOrientationProperty: true])

    guard let image = image else { return }
    displayView.image = UIImage.init(ciImage: image)

  }

  fileprivate func distort(center: CIVector) {
    let filter = HoleDistortionFilter()
    filter.inputImage = image
    filter.center = center
    let filteredImage = filter.outputImage?.cropped(to: image?.extent ?? CGRect(origin: CGPoint(x: 100,y: 100), size: CGSize(width: 100, height: 100)))
    displayView.image = UIImage(ciImage: (filteredImage) ?? CIImage())
  }

  @IBAction func sliderChanged(_ sender: UISlider) {
    if sender.value == 1.0 {
      displayView.image = UIImage.init(ciImage: image ?? CIImage())
      return
    }

    distort(center: CIVector(x: CGFloat(sender.value), y: CGFloat(sender.value)))

  }
  @IBAction func touchDragged(_ sender: UIPanGestureRecognizer) {
    let touch = sender.location(in: sender.view)

    let x = touch.x  / sender.view!.bounds.width
    let y = touch.y / sender.view!.bounds.height
    print("touch is at \(x), \(y)")
    distort(center: CIVector(x: CGFloat(x), y: CGFloat(y)))
  }
}

