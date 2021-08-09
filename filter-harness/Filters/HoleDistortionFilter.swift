//
//  HoleDistortionFilter.swift
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
  var inputCenter = CIVector(x: 0.5, y: 0.3)
  var inputParameters = CIVector(x: 1/0.08, y: 0.08)


  override var outputImage: CIImage? {
    guard let inputImage = inputImage else { return .none }
    return kernel.apply(extent: inputImage.extent,
                        roiCallback: { (index, rect) -> CGRect in
                          return rect
                        }, arguments: [inputImage, inputCenter, inputParameters])
  }
}
