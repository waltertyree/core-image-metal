//
//  MonochromeFilter.swift
//

import CoreImage

class MonochromeFilter: CIFilter {
  private lazy var kernel: CIKernel = {
    guard
      let url = Bundle.main.url(forResource: "default", withExtension: "metallib"),
      let data = try? Data(contentsOf: url) else {
      fatalError("Unable to load metallib")
    }
    
    guard let kernel = try? CIKernel(functionName: "monochromeFilterKernel", fromMetalLibraryData: data) else {
      fatalError("Unable to create the CIKernel for monochromeFilterKernel")
    }
    
    return kernel
  }()
  
  var inputImage: CIImage?
  var inputTintColor: CIColor?

  override var outputImage: CIImage? {
    guard let inputImage = inputImage else { return .none }
    guard let inputTintColor = inputTintColor else { return .none}
    let inputColor: CIVector = CIVector(x: inputTintColor.red, y: inputTintColor.green, z: inputTintColor.blue, w: inputTintColor.alpha)
    return kernel.apply(extent: inputImage.extent,
                        roiCallback: { (index, rect) -> CGRect in
                          return rect
                        }, arguments: [inputImage, inputColor])
  }
}
