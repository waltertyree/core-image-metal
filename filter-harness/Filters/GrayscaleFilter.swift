//
//  GrayscaleFilter.swift
//


import CoreImage

class GrayscaleFilter: CIFilter {
  static var kernel: CIColorKernel = { () -> CIColorKernel in
    let url = Bundle.main.url(forResource: "default",
                              withExtension: "metallib")!
    let data = try! Data(contentsOf: url)
    return try! CIColorKernel(functionName: "grayscaleFilterKernel",
                              fromMetalLibraryData: data)
  }()

  var inputImage: CIImage?

  override var outputImage: CIImage? {
    guard let inputImage = inputImage else { return .none }
    return GrayscaleFilter.kernel.apply(extent: inputImage.extent,
                        roiCallback: { (index, rect) -> CGRect in
                          return rect
                        }, arguments: [inputImage])
  }

  //These are needed when we want to use our filter with the "stringly typed" api

  override func setValue(_ value: Any?, forKey key: String) {
          switch key {
              case "inputImage":
                inputImage = value as? CIImage
              default:
                  break
          }
      }

  override var attributes: [String : Any] {
          return [
              kCIAttributeFilterDisplayName: "Custom Grayscale Filter",

              "inputImage": [kCIAttributeIdentity: 0,
                             kCIAttributeClass: "CIImage",
                             kCIAttributeDisplayName: "Image",
                             kCIAttributeType: kCIAttributeTypeImage]
          ]
      }
}
