# DrawJuliaSet

A simple program to generate and visualize Julia set fractals.

## 🧠 Project Overview

DrawJuliaSet computes and renders Julia‑set fractals by iterating the classical complex quadratic map \( f_c(z) = z^2 + c \).  
For a given complex constant `c`, the program evaluates each point \(z\) in a region of the complex plane. Points that remain bounded after a certain number of iterations are classified as belonging to the Julia set; others diverge and are colored according to their escape time. The result is a fractal image that reveals intricate, self‑similar boundary structures characteristic of Julia sets. :contentReference[oaicite:2]{index=2}

This project serves both as an educational tool to explore complex dynamics, and a small graphical utility to produce fractal art.

## ✨ Features

- Supports drawing Julia sets for arbitrary complex parameter `c`.  
- Generates a 2D image visualizing the bounded/unbounded behavior of complex points.  
- Allows adjustment of parameters (e.g. iteration limit, view window, zoom) to explore different Julia patterns.  
- Output saved as image (or displayed) for further inspection.

## 📸 Example Output

*(You can insert a sample image of the generated Julia set here)*

## 🛠 Implementation Details

- Uses iteration of \( z \leftarrow z^2 + c \) over a grid of complex values. :contentReference[oaicite:3]{index=3}  
- Determines escape by checking whether \(|z|\) exceeds a preset threshold (escape radius), or whether the number of iterations surpasses a max‑iteration count.  
- Colors each pixel based on the number of iterations required to escape (or remain bounded), producing fractal boundary visuals.  
- Parameter `c`, zoom level, resolution, and iteration settings are configurable, enabling exploration of a wide variety of Julia‑set shapes.

## 🤝 Contribution

Feel free to submit bug reports or pull requests. Possible extensions:

- Add interactive zooming & panning  
- Export high‑resolution images  
- Support different complex maps (e.g. higher‑power polynomials, other fractals)  
- Add color palettes or continuous coloring schemes  

## 📄 License

This project currently does not specify a license. Consider adding a permissive license (e.g. MIT) if you want others to reuse or contribute.

