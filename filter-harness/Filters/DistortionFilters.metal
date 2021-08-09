//
//  DistortionFilters.metal
//
//

#include <metal_stdlib>
using namespace metal;

#include <CoreImage/CoreImage.h>

extern "C" {
  namespace coreimage {
    // KERNEL
    //adapted from https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_custom_filters/ci_custom_filters.html#//apple_ref/doc/uid/TP30001185-CH6-SW4

    //this can only create a general filter because of the function signature
    float4 holeDistortionKernel(sampler src, float2 center, float2 params) {
      float2 t1;
      float distance0, distance1;
      t1 = src.coord() - center;

      distance0 = dot(t1, t1);
      t1 = t1 * (1.0 / sqrt(distance0));
      distance0 = distance0 * (1.0 / sqrt(distance0)) * params.x;
      distance1 = distance0 - (1.0 / distance0);
      distance0 = compare(distance0, 0.0, distance1) * params.y;
      t1 = t1 * distance0 + center;

      return src.sample(t1);
    }

  }
}

