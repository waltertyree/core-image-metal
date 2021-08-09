//
//  ColorFilters.metal
//

#include <metal_stdlib>
using namespace metal;

#include <CoreImage/CoreImage.h>

extern "C" {
  namespace coreimage {
    //This can only create a Color filter because of the function signature
    float4 grayscaleFilterKernel(sample_t s) {
      float gray = (s.r + s.g + s.b) / 3;
      return float4(gray, gray, gray, s.a);
    }


    //This can only create a general filter because of the funciton signature
    float4 monochromeFilterKernel(sampler src, float4 monoColor) {
      float4 s = src.sample(src.coord());
      float gray = (s.r + s.g + s.b) / 3;
      return float4(gray * monoColor.r, gray * monoColor.g, gray * monoColor.b, s.a);
    }
  }
}

