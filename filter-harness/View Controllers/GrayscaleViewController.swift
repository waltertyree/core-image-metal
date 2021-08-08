//
//  GrayscaleViewController.swift
//

import UIKit
import CoreImage

class GrayscaleViewController: UIViewController {


  @IBOutlet var filterSelector: UISegmentedControl!
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

  @IBAction func selectorChanged(_ sender: UISegmentedControl) {
    if sender.selectedSegmentIndex == 0 { //display normal
      loadCleanImage()
      return
    }

    if sender.selectedSegmentIndex == 1 { //apply filter
      let filter = GrayscaleFilter()
      filter.inputImage = image

      displayView.image = UIImage(ciImage: (filter.outputImage ?? image) ?? CIImage())
    }
  }

}
