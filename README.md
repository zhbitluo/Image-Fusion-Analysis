# Image-Fusion-Analysis #
A repository multifocus Image Fusion using Matlab
---
* Findings:
1. According to imaging mechanism of optical system, the bandwidth of system function for images in focus is wider than that for images out of focus.
2.The modified PatchMatch: Given two images A = I1 and
B = Ii, and a distance D between local neighborhoods (patches),
the PatchMatch algorithm heuristically finds a geometrical mapping
' that minimizes Px D(PA(x), PB('(x))), where PA(x) is the
patch centered on x in A. The algorithm is usually used with D being
the L2 distance. But in our case, this choice fails badly because
of the varying amount of blur. To mitigate this, we combine two solutions.
The first is to replace the L2 distance by a more blur-robust
comparison, and the second is to apply PatchMatch in a multi-scale
manner. That is to say, we obtain a displacement map for a coarse
version of the images, interpolate it to a finer scale and take this as a
seed for the PatchMatch at the finer scale (by doing so, we constrain
the search in PatchMatch at a finer scale not to deviate too much
from the coarser displacement map). We repeat this process until the
finest scale is attained. This multiscale approach enforces coherence
of the final result. 

---
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/15443865bb564f71b38efa8630046d44)](https://www.codacy.com/app/rtzdzn/Image-Fusion-Analysis?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=ritwikraha/Image-Fusion-Analysis&amp;utm_campaign=Badge_Grade)
