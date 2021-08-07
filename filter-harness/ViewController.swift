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

  @IBAction func sliderChanged(_ sender: UISlider) {
    if sender.value == 1.0 {
      displayView.image = UIImage.init(ciImage: image ?? CIImage())
      return
    }

    var uiColorFromSlider = UIColor(hue: CGFloat(sender.value), saturation: 1.0, brightness: 1.0, alpha: 1.0)
    if sender.value == 0.0 {
      uiColorFromSlider = UIColor.white
    }
    let colorFromSlider = CIColor(color: uiColorFromSlider)
    let filter = GrayscaleFilter()
    filter.inputImage = image
    filter.monoColor = colorFromSlider

    displayView.image = UIImage(ciImage: (filter.outputImage ?? image) ?? CIImage())

  }
}

