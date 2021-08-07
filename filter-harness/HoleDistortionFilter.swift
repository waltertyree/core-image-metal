//
//  HoleDistortionFilter.swift
//  filter-harness
//
//  Created by Walter Tyree on 8/6/21.
//


import CoreImage

class HoleDistortionFilter: CIFilter {
  private lazy var kernel: CIKernel = {
    guard
      let url = Bundle.main.url(forResource: "default", withExtension: "metallib"),
      let data = try? Data(contentsOf: url) else {
      fatalError("Unable to load metallib")
    }

    guard let kernel = try? CIKernel(functionName: "holeDistortionKernel", fromMetalLibraryData: data) else {
      fatalError("Unable to create the CIKernel for holeDistortionKernel")
    }

    return kernel
  }()

  var inputImage: CIImage?
  var center = CIVector(x: 0.5, y: 0.3)
  var param = CIVector(x: 1/0.18, y: 0.18)


  override var outputImage: CIImage? {
    guard let inputImage = inputImage else { return .none }
    return kernel.apply(extent: inputImage.extent,
                        roiCallback: { (index, rect) -> CGRect in
                          return rect
                        }, arguments: [inputImage, center, param])
  }
}
