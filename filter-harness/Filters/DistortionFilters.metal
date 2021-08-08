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
    // KERNEL
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

