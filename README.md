# DrawJuliaSet

An ARM Assembly program that renders and animates **Julia set fractals** directly on the framebuffer (`/dev/fb0`). The project demonstrates low-level graphics computation entirely in Assembly without using any high-level programming languages.

---

## 🧠 Project Overview

This program computes the Julia set fractal for a given complex constant `c` and displays it on a 640×480 screen. Each pixel is calculated using integer arithmetic, iterating the complex quadratic map:

```
f_c(z) = z^2 + c
```

The number of iterations before `|z|` exceeds a threshold determines the pixel's color. Users can interactively trigger the animation by pressing the `p` key.

---

## ✨ Features

* Full **ARM Assembly implementation** for pixel-level fractal computation.
* **Integer arithmetic** is used for all calculations to optimize speed and avoid floating-point operations.
* **Framebuffer direct access** (`/dev/fb0`) for high-performance rendering.
* **Escape-time coloring**: maps iteration counts to 16-bit color values for vivid visualization.
* Supports **interactive animation** with user input.
* Efficient **nested loops** iterate over all pixels in X and Y directions.

---

## 🖼 Example

*(Insert sample Julia Set screenshot here)*

---

## 🛠 Design Highlights

* Uses a **double loop** (X and Y) to compute each pixel individually.
* Computes initial `zx` and `zy` for each pixel using integer scaling.
* Implements the **Julia iteration** in Assembly, with early exit when the escape condition is met.
* Pixel color is determined by the iteration count and written directly to the framebuffer.
* Includes simple user interface prompts and messages, all printed via Assembly routines.

---

