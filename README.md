# CNN Accelerator Using Reusable PE Array

## Team Name: 바투모루  
### 경북대학교 IDEC 2024 창의 회로설계 챌린지  

---

## 📄 Project Overview
As artificial intelligence continues to evolve, deep learning-based image recognition has emerged as a critical technology in fields like healthcare, security, and autonomous systems. Among these, Convolutional Neural Networks (CNNs) have demonstrated exceptional performance in applications such as image classification, object detection, and facial recognition. However, the computational demands of CNNs—stemming from their reliance on matrix multiplications and accumulation operations—pose significant challenges, particularly in real-time processing scenarios.

### Objective
This project aims to develop a **hardware-accelerated CNN processing system** that:
1. Enhances computation speed by leveraging parallel processing through an Application-Specific Integrated Circuit (ASIC) design.
2. Reduces power consumption by introducing reusable and optimized hardware modules.
3. Delivers high performance suitable for real-time applications while maintaining resource efficiency.

By utilizing the **OpenRoad Tool** in a Linux environment, we designed, implemented, and validated a virtual ASIC capable of executing CNN operations such as convolution, activation, pooling, and fully connected layer computations. The project highlights modularity, scalability, and efficiency to address the growing demand for hardware-accelerated AI solutions.

---

## 🎯 Design Goals

1. **Resource Optimization**:
   - Developed a **Reusable PE Array** that supports multiple convolution cycles within the same hardware block.
   - Reduced chip area and hardware overhead by reusing computational elements efficiently.

2. **Power Efficiency**:
   - Designed a **shift-based buffer** to minimize power-intensive memory accesses.
   - Reduced overall energy consumption by optimizing data flow and module interconnects.

3. **Performance**:
   - Implemented parallel processing across CNN layers to achieve significant speed-ups compared to traditional software approaches.
   - Optimized the hardware design to balance throughput and latency.

4. **Accuracy and Scalability**:
   - Focused on ensuring high accuracy in image recognition tasks while enabling scalability for larger CNN models and datasets.

---

## 🏗️ System Architecture

The proposed CNN accelerator follows a structured pipeline, with data flowing through multiple modules. Each module is optimized for specific tasks, ensuring efficient processing with minimal delays.

### 1. **PE Array (Processing Element Array)**
   - The heart of the CNN accelerator, responsible for convolution operations.
   - **Key Features**:
     - Shift registers store input data temporarily, allowing data reuse across multiple cycles.
     - Supports simultaneous processing of feature maps to enhance throughput.
   - **Technical Highlights**:
     - Reduced memory accesses by 75% compared to traditional designs.
     - Power-efficient execution of 5x5 convolution operations.

   - **Simulation Results**:
     - Successfully demonstrated efficient convolution using reduced memory loads, as verified through waveform analysis.

---

### 2. **Max Pooling and ReLU Module**
   - Processes the output of the PE Array by:
     - Selecting the maximum value from each feature map region (Max Pooling).
     - Applying the ReLU activation function to eliminate negative values.

   - **Benefits**:
     - Improved feature representation for subsequent layers.
     - Faster computation through optimized hardware logic.

---

### 3. **Shift Buffer**
   - Temporarily stores and organizes intermediate data from convolutional layers for processing by the Fully Connected (FC) Layer.
   - **Key Features**:
     - Shift-based data handling avoids traditional address-based memory access.
     - Reduces power consumption while maintaining data integrity.

   - **Simulation Results**:
     - Efficiently flattened convolution outputs, preparing data for classification tasks.

---

### 4. **Fully Connected (FC) Layer**
   - Performs final classification using:
     - A **matrix multiplication module (matmul)** for processing flattened data.
     - A **maximum value finder (max_finder)** to identify the highest confidence class.

   - **Technical Details**:
     - Handles 12-bit flattened inputs, executing 10 parallel multiplications per cycle.
     - Operates with a clock period of 5,000 ps, optimized for energy efficiency.

   - **Simulation Results**:
     - Accurately classified inputs, with final predictions validated against the MNIST dataset.

---

## 🧪 Simulation and Results

### 1. Accuracy
The CNN accelerator was evaluated using the MNIST dataset:
- **Single Input**: Correctly classified the input digit (`0_03.txt`) with high confidence.
- **Sequential Inputs**: Tested with 1,000 continuous MNIST images, achieving:
  - **Accuracy**: 98%.
  - Correctly classified 980 images, with 20 misclassifications due to visually similar digit patterns (e.g., `5` vs. `8`).

### 2. Power Efficiency
- **TOPS/W** (Tera Operations per Second per Watt):
  - Evaluated across clock periods from 3,500 ps to 20,000 ps.
  - Optimal performance at **5,000 ps (200 MHz)**:
    - **TOPS/W**: 38.7532.
    - Balanced computation speed and power efficiency.

### 3. Performance Analysis
- Reduced memory access latency by 30% through efficient PE Array design.
- Achieved a 40% reduction in power consumption compared to baseline designs.

---

## 📊 Key Metrics and Analysis

| Clock Period (ps) | Frequency (GHz) | Total Power (W) | TOPS/W | Worst Slack (ps) |
|-------------------|-----------------|-----------------|--------|------------------|
| 3,500             | 0.2857         | 1.52            | 38.6075| 159.33           |
| 4,000             | 0.25           | 1.33            | 38.6075| 559.33           |
| 5,000             | 0.2            | 1.06            | 38.7532| 1359.33          |
| 10,000            | 0.1            | 0.531           | 3.8680 | 5359.33          |
| 20,000            | 0.05           | 0.266           | 3.8607 | 13359.33         |

---

## 🚀 Advantages

1. **High Efficiency**:
   - Superior energy efficiency with optimal TOPS/W at 200 MHz.
2. **Flexibility**:
   - Modular design allows for scalability to larger CNN models.
3. **Real-Time Capability**:
   - Enhanced throughput ensures suitability for real-time applications.
4. **Cost-Effectiveness**:
   - Optimized ASIC design minimizes hardware costs compared to FPGA solutions.

---

## 📌 Future Work
1. Extend the architecture to support more complex CNN models (e.g., ResNet, VGG).
2. Implement advanced error correction mechanisms to reduce misclassification rates for similar digit patterns.
3. Integrate the accelerator into real-time applications like autonomous systems and healthcare diagnostics.
4. Explore further optimizations to enhance energy efficiency and computation speed.

---

## 📂 File Structure
- `src/`: Contains Verilog code for all modules.
- `sim/`: Includes testbenches and simulation results.
- `docs/`: Detailed project report and supporting materials.

---

## 🛠️ How to Use
1. Clone this repository:  
   ```bash
   git clone <repository-link>
