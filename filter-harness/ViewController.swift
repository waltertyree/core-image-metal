//
//  ViewController.swift
//  filter-harness
//
//  Created by Walter Tyree on 8/5/21.
//

import UIKit
import CoreImage

class ViewController: UIViewController {


  @IBOutlet var filterToggle: UISwitch!
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

  @IBAction func switchToggled(_ toggle: UISwitch) {
    if toggle.isOn {
      //let filter = CIFilter(name: "CIPhotoEffectChrome", parameters: [kCIInputImageKey: image])
      let filter = GrayscaleFilter()
      filter.inputImage = image
      displayView.image = UIImage.init(ciImage: (filter.outputImage ?? image) ?? CIImage())
    } else {
      displayView.image = UIImage.init(ciImage: image ?? CIImage())
    }
  }

}

