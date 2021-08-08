//
//  ColorFilters.metal
//  filter-harness
//
//  Created by Walter Tyree on 8/5/21.
//

#include <metal_stdlib>
using namespace metal;

#include <CoreImage/CoreImage.h>

extern "C" {
  namespace coreimage {
    // KERNEL GOES HERE
    float4 grayscaleFilterKernel(sample_t s) {
      float gray = (s.r + s.g + s.b) / 3;
      return float4(gray, gray, gray, s.a);
    }


    float4 monochromeFilterKernel(sampler src, float4 monoColor) {
      float4 s = src.sample(src.coord());
      float gray = (s.r + s.g + s.b) / 3;
      return float4(gray * monoColor.r, gray * monoColor.g, gray * monoColor.b, s.a);
    }
  }
}

