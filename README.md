### Phalcon Viz with Gource

#### Requirements
Assuming Homebrew is installed
- $`brew install glew`
- $`brew install sdl`
- $`brew install libpng`
- $`brew install libtiff`
- $`brew install webp`
- $`brew install jpeg`

#### Build Gource
From project root
- $`cd Gource`
- $`./configure`
- $`make install`

#### Make Video
From project root
- $`./run.sh`

#### Caveats
- The homebrew version of php7 requires jpeg 8d you might need to switch it back after using gource `brew switch jpeg 8d`


This was built thanks to inspiration from @TheLarkInn
