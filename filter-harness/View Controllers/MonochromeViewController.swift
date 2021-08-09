//
//  MonochromeViewController.swift
//

import UIKit
import CoreImage

class MonochromeViewController: UIViewController {


  @IBOutlet var colorView: UIView!
  @IBOutlet var filterSlider: UISlider!
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
  }

  fileprivate func applyMonochromeFilter(_ monoColor: UIColor) {
    let colorFromSlider = CIColor(color: monoColor)

    let filter = MonochromeFilter()
    filter.inputImage = image
    filter.inputTintColor = colorFromSlider

    displayView.image = UIImage(ciImage: (filter.outputImage ?? image) ?? CIImage())
  }

  @IBAction func sliderChanged(_ sender: UISlider) {
    if sender.value == 1.0 {
      loadCleanImage()
      colorView.backgroundColor = .none
      return
    }

    var uiColorFromSlider = UIColor(hue: CGFloat(sender.value), saturation: 1.0, brightness: 1.0, alpha: 1.0)
    if sender.value == 0.0 {
      uiColorFromSlider = UIColor.white
    }
    colorView.backgroundColor = uiColorFromSlider

    applyMonochromeFilter(uiColorFromSlider)

  }
}
