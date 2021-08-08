//
//  GrayscaleFilter.swift
//  filter-harness
//
//  Created by Walter Tyree on 8/8/21.
//
//


import CoreImage

class GrayscaleFilter: CIFilter {
  var inputImage: CIImage?
  var inputParam: Float = 0.0
  static var kernel: CIColorKernel = { () -> CIColorKernel in
    let url = Bundle.main.url(forResource: "default",
                              withExtension: "metallib")!
    let data = try! Data(contentsOf: url)
    return try! CIColorKernel(functionName: "grayscaleFilterKernel",
                              fromMetalLibraryData: data)
  }()

  override var outputImage: CIImage? {
    guard let inputImage = inputImage else { return .none }
    return GrayscaleFilter.kernel.apply(extent: inputImage.extent,
                        roiCallback: { (index, rect) -> CGRect in
                          return rect
                        }, arguments: [inputImage])
  }
}
