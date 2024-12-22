# CNN Accelerator Using Reusable PE Array

## Team Name: 바투모루  
### 경북대학교 IDEC 2024 창의 회로설계 챌린지  

---

## 📄 Project Overview
With the rapid advancement of artificial intelligence, deep learning-based image recognition technology is gaining attention in various fields. Convolutional Neural Networks (CNNs) have proven their high performance in tasks like image classification, object detection, and face recognition, forming the backbone of modern computer vision systems. However, CNNs face challenges due to their computationally intensive operations, including matrix multiplications and accumulations, which can lead to high power consumption and limitations in real-time processing.

This project aims to design an **ASIC-based CNN accelerator** to address these challenges by:
- Parallelizing complex CNN operations to enhance processing speed.
- Reducing power consumption through architectural optimization.
- Designing reusable hardware modules for efficient resource utilization.

The implementation leveraged the OpenRoad tool in a Linux environment to develop and verify a virtual ASIC design optimized for CNN operations such as convolution, activation, pooling, and fully connected layers. By modularizing these computations, we achieved significant improvements in execution speed and energy efficiency compared to traditional software-based approaches.

---

## 🎯 Design Goals
The project focuses on creating a CNN accelerator with the following objectives:

1. **Enhancing Resource Reusability**:
   - Developed a **Reusable PE (Processing Element) Array** that supports multiple convolution operations within a single hardware module.
   - By reusing the same PE Array across different computation cycles, hardware utilization was optimized, reducing waste and chip area.

2. **Optimizing Power Consumption**:
   - Designed a **shift-based buffer** to store intermediate results, eliminating the need for address-based memory access.
   - This approach reduced unnecessary power consumption and improved energy efficiency.

3. **Improving Computation Speed**:
   - Adopted parallel processing in ASIC architecture to outperform traditional software-based CNN computations.
   - Focused on minimizing data transfer overhead and memory access latency to achieve faster processing.

---

## 🏗️ System Architecture
The proposed CNN architecture follows a streamlined flow from input to final output, consisting of several specialized modules:

### 1. **PE Array (Processing Element Array)**
   - Core module for performing convolution operations.
   - **Features**:
     - Uses shift registers to store data temporarily, reducing redundant memory accesses.
     - Supports simultaneous processing of multiple data points to enhance throughput.
     - Generates partial output feature maps for further processing.
   - **Results**:
     - Demonstrated significant power savings by reusing loaded data.
     - Achieved efficient convolution with reduced memory access overhead.

### 2. **Max Pooling and ReLU Module**
   - Processes the output of the PE Array by:
     - Selecting the maximum value in a feature map region (Max Pooling).
     - Applying the ReLU activation function to discard negative values.
   - **Results**:
     - Improved data quality for subsequent layers.
     - Ensured faster computations with optimized logic.

### 3. **Shift Buffer**
   - Temporarily stores and organizes convolution results before passing them to the Fully Connected (FC) Layer.
   - **Features**:
     - Shift-based data handling eliminates the need for explicit address computation.
     - Ensures data readiness for FC Layer processing.
   - **Results**:
     - Flattened and structured data efficiently for final classification.

### 4. **Fully Connected (FC) Layer**
   - Performs the final classification by:
     - Matrix multiplication using a dedicated **matmul** module.
     - Selecting the maximum value using a **max_finder** module for output prediction.
   - **Results**:
     - Delivered accurate classification with minimal latency.
     - Reduced computation complexity through optimized hardware design.

---

## 🧪 Simulation Results
The CNN accelerator was tested on the MNIST dataset for single and sequential inputs. Key findings include:

### 1. **Accuracy Testing**
   - **Single Input**: Achieved accurate classification of the input digit (`0_03.txt`).
   - **Sequential Inputs**: Tested with 1,000 continuous MNIST images.
     - Accuracy: **98%**.
     - Correctly classified 980 images, with 20 misclassifications due to visually similar digit patterns (e.g., `5` mistaken as `8`).

### 2. **Power Efficiency**
   - Evaluated using the **TOPS/W** metric (Tera Operations per Second per Watt).
   - Optimal performance observed at:
     - **Clock Period**: 5,000 ps (200 MHz).
     - **TOPS/W**: **38.7532**.
   - Highlighted balance between power consumption and computational performance.

---

## 🚀 Advantages of the Proposed Design
1. **High Performance**:
   - Parallel processing improved CNN computation speed compared to software implementations.
2. **Energy Efficiency**:
   - Reduced power consumption through reusable modules and optimized data handling.
3. **Scalability**:
   - Modular design allows integration into various real-time image processing applications.
4. **Cost-Effectiveness**:
   - ASIC-based implementation reduces hardware overhead compared to FPGA-based solutions.

---

## 📊 Key Metrics and Analysis
### Post-Synthesis Results:
| Clock Period (ps) | Frequency (GHz) | Total Power (W) | TOPS/W | Worst Slack (ps) |
|-------------------|-----------------|-----------------|--------|------------------|
| 3,500             | 0.2857         | 1.52            | 38.6075| 159.33           |
| 4,000             | 0.25           | 1.33            | 38.6075| 559.33           |
| 5,000             | 0.2            | 1.06            | 38.7532| 1359.33          |
| 10,000            | 0.1            | 0.531           | 3.8680 | 5359.33          |
| 20,000            | 0.05           | 0.266           | 3.8607 | 13359.33         |

### Conclusion:
- The CNN accelerator performs optimally at **200 MHz**, achieving high accuracy and power efficiency, making it suitable for real-time applications.

---

## 📌 Future Work
- Extend the design to support larger and more complex CNN models.
- Explore further optimizations to reduce misclassification rates for visually similar patterns.
- Integrate the accelerator into a real-time image processing system to validate its performance in practical applications.
