# Digital-ONN-on-FPGA
A fully digital Oscillatory Neural Network (ONN) implemented in Verilog on the Digilent Zybo Z7 FPGA for associative memory-based image recognition. The design uses Hebbian learning to store binary image patterns and performs pattern retrieval through phase-based neural computation.

## What is an Oscillatory Neural Network (ONN)?

An Oscillatory Neural Network (ONN) is a neuromorphic computing architecture in which neurons are represented by coupled oscillators instead of conventional artificial neurons. Information is encoded in the relative phase relationships between oscillators rather than voltage amplitudes. Through synchronization dynamics, the network naturally converges to stored patterns, enabling efficient associative memory and pattern recognition.
## Why Oscillatory Neural Networks?

Compared to conventional neural network implementations, ONNs offer several advantages:

- Phase-based computation instead of amplitude-based logic.
- Intrinsic parallel computation through oscillator synchronization.
- Fast convergence to stored patterns using associative memory.
- Low-power operation, making them suitable for edge AI applications.
- Efficient hardware implementation using FPGA and emerging oscillator technologies.

## Key Features

- Fully digital Oscillatory Neural Network (ONN) implemented in Verilog HDL.
- Designed and deployed on the Digilent Zybo Z7 FPGA.
- Supports associative memory-based image recognition using oscillator synchronization.
- Uses Hebbian associative learning to generate the synaptic weight matrix.
- Tested on both **5 × 3 (15-neuron)** and **10 × 6 (60-neuron)** ONN architectures.
- Validated through functional simulation in Xilinx Vivado and FPGA implementation.
- Scalable architecture for exploring larger ONN-based neuromorphic systems.

## Architecture

<p align="center">
  <img src="images/digital_onn_architecture.png" width="900">
</p>

<p align="center">
<b>Figure 2.</b> Architecture of the fully digital Oscillatory Neural Network implemented on FPGA.
</p>

The digital ONN is composed of three major modules:

### Control Blocks
- Generate the slow clock required for oscillator operation.
- Serially initialize neuron states using the `serial2states` module.
- Monitor network convergence through `steady_check` and `inconsistent_check` signals.
- Control synchronization and overall network execution.

### Synapse Block
- Stores the Hebbian-trained synaptic weight matrix.
- Computes weighted interactions between all neurons.
- Generates the input (`nin`) for every neuron based on the current network state.
- Implements fully parallel associative coupling across the network.

### Neuron Array
- Consists of identical neuron modules connected through the synapse network.
- Each neuron contains:
  - Phase Calculator
  - Phase-Controlled Oscillator
  - State Register
- Neurons continuously update their phases until the entire network converges to the closest stored pattern.

### Overall Operation
1. The input pattern is serially loaded into the neuron array.
2. The synapse block computes the weighted neuron interactions using the stored Hebbian weights.
3. Each neuron updates its oscillator phase according to the computed inputs.
4. The network iteratively synchronizes until a stable state is reached.
5. The final neuron states represent the retrieved image pattern.
