# DrawJuliaSet

An ARM Assembly program that renders and animates **Julia set fractals** directly on the framebuffer. The project demonstrates low-level graphics computation entirely in Assembly without using any high-level programming languages.

---

## 🧠 Project Overview

This program computes the Julia set fractal for a given complex constant `c` and displays it on a screen. Each pixel is calculated using integer arithmetic, iterating the complex quadratic map:

```
f_c(z) = z^2 + c
```

The number of iterations before `|z|` exceeds a threshold determines the pixel's color. Users can interactively trigger the animation by pressing the `p` key.

---

## ⚡ Key Highlights

* Full ARM Assembly implementation.
* Computes each pixel using integer arithmetic.
* Direct framebuffer access for 640×480 rendering.
* Escape-time coloring mapped to 16-bit pixel values.
* Nested X/Y loops with early exit for iterations.
* Interactive animation triggered by key input.
* Efficient low-level memory and loop control.

---

## 🖼 Example

![Julia Set Example 1](https://github.com/pinwei123/DrawJuliaSet/raw/main/picture/6.png)

![Julia Set Example 2](https://github.com/pinwei123/DrawJuliaSet/raw/main/picture/3.png)

---
