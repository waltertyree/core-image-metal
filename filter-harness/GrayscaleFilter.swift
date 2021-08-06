//
//  GrayscaleFilter.swift
//  filter-harness
//
//  Created by Walter Tyree on 8/5/21.
//

import CoreImage

class GrayscaleFilter: CIFilter {
  private lazy var kernel: CIKernel = {
    guard
      let url = Bundle.main.url(forResource: "default", withExtension: "metallib"),
      let data = try? Data(contentsOf: url) else {
      fatalError("Unable to load metallib")
    }
    
    guard let kernel = try? CIColorKernel(functionName: "grayscaleFilterKernel", fromMetalLibraryData: data) else {
      fatalError("Unable to create the CIColorKernel for grayscaleFilterKernel")
    }
    
    return kernel
  }()
  
  var inputImage: CIImage?
  var monoColor: CIVector = CIVector(x: 0.22, y: 0.93, z: 0.17, w: 1.0)
  
  override var outputImage: CIImage? {
    guard let inputImage = inputImage else { return .none }
    
    return kernel.apply(extent: inputImage.extent,
                        roiCallback: { (index, rect) -> CGRect in
                          return rect
                        }, arguments: [inputImage, monoColor])
  }
}
