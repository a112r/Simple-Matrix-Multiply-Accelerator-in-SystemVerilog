# Systolic Matrix Multiply Engine

An attempt to make a lightweight, FPGA-compatible systolic array-based matrix multiply engine inspired by Googles TPUs(Tensor Processing Units)— a simple project to get a better understanding of how TPUs actually do what they do.

This is a small hardware project using a **systolic array** architecture, it multiplies two 4×4 matrices of signed 8-bit integers and outputs a 4×4 result of 16-bit values (to hold the accumulated results. designed in **SystemVerilog**, the goal was to understand the core computational structure behind machine learning accelerators like Google's **TPU**, without getting buried in the complexity of memory hierarchies, software stacks, or high-level frameworks.

## About the project

- `pe.sv` – The **processing element**. It performs multiply-and-accumulate and passes data along.
- `systolic_array.sv` – A **4×4 grid of PEs**, wired together to form the systolic array.
- `tpu_tb.sv` – A simple **testbench** to simulate a matrix multiply operation in ModelSim.

The design is made to be tested using **Quartus** and **ModelSim**, and it’s targeted for the **DE1-SoC FPGA board** since thats what I have experience with.

---

## 💡 Why systolic arrays?

Systolic arrays are cool. They’re used in real TPUs to do matrix operations in a pipelined, rhythmic fashion. In hardware terms, this means:
- No big shared memory
- Each cell (processing element) just talks to its neighbors
- Data flows in like a wave across the array

It’s a great way to compute dot products efficiently, and that’s at the heart of neural network math - atleast afaik.

---

## How to get it to work (hopefully)

1. Open project in Quartus with all .sv files.
2. Simulate `tpu_tb.sv` using ModelSim to verify the matrix multiply.
3. (Maybe) Hook it up to switches, LEDs, or UART to feed in real data on the DE1-SoC.

---

## What this basically is:
- A real, working **hardware matrix multiplier**
- A way to learn how TPUs accelerate matrix math, atleast from my understanding
- It is ofc not a full TPU (no memory controller, no instruction pipeline, no deep learning support)
- Just something I felt like making cuz why not

## ✨ Next Steps (if and when I get time...)

- Add input/output buffering
- Support for bigger matrices (though unlikely )
- Maybe chain this with a ReLU block?

---

## 📚 Resources I used

- Googles blogs I found online (- [An in-depth look at Google’s first Tensor Processing Unit (TPU)](https://cloud.google.com/blog/products/ai-machine-learning/an-in-depth-look-at-googles-first-tensor-processing-unit-tpu) – awesome deep dive from the original TPU team)
- Chat gpt explaining to me parallel hardware with examples (Idk if those would run but also I don't know if this project would either)
- Random YouTube videos explaining systolic arrays
