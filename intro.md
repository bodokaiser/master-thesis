Todos:
- [] Background information, context, importance?
- [] How does CV-QKD fit in? 

## Introduction to the introduction 

### Subject area 

Quantum optical communication -> Use quantum properties of light for enhanced and novel solutions to communication problems.

### Thesis' aim

1. Develop a theoretical formalism for quantum optical communication
2. Understand how the CV-QKD prototype works

### Research problem

* Typical quantum optics misses important aspects required for signal-processing.

### Research questions

* What is the scope and validity of quantum optics?
* How to derive the results claimed by Barnett, Loudon, and Shapiro?
* How to properly (consistenly) incorporate a frequency spectrum into the quantum state?
* What is the physicality of the frequency spectrum?

### Contribution

* We develope a theoretical foundation for quantum optical communication from established and fundamental QFT.
* We apply our theoretical foundation to describe electro-optical components essential for optical communication systems.
* We present an abstract notion of QKD protocols.
* We discuss the complete signal flow (digital, analog, quantum) for a coherent state transmission system used for CV-QKD.

### Objectives and findings

* Understand and motivate every step (no claiming)
* Transparent assumptions

## Overarching topic and aims of the thesis in more detail 

### Context

* Quantum optical communication -> QKD
* Optical communication, Quantum optics

### Brief literature review

Continous-mode formalism in Loudon, Shapiro, Barnett

## Definition of terms and scope of the topic

### Definitions

* Mode
* Single-, multi-, continuous-mode
* Quantum optical communication
* CV-QKD

### Scope

We assume that the reader is educated in
* advanced quantum mechancis
* single-mode quantum optics
* signal-processing
* basic optical communication

We perform no experiment!

## Critically evaluate the current state of the literature on the topic and identify your gap

### Current state of the literature

#### Single- and multi-mode quantum optics

* Gerry & Knight
* Fox

#### Continuos-mode quantum optics

* Loudon
* Barnett
* Shapiro

#### Advanced literature

* Vogel
* Mandel & Wolf

#### Optical communication

* Kikuchi

#### Quantum field theory

* Itzykson
* Peskin & Schroeder
* Greiner
* Stone?
* ...

### Shortcomings of the current literature

* Single-mode quantum optics lack notion of frequency spectrum.
* Continuous-mode quantum optics unclear/unjustified
* Advanced literature very problem specific
* Quantum field theory applied to different problems (scattering amplitudes)

## Outline why the research is important and the contribution that it makes
 
* The theory presented in the thesis allows the transfer of methods from (optical) communication to quantum optics.
* The thesis provides a deep understanding into a complete quantum description of light towards communication.

## State the hypotheses

Quantum field theory provides the most complete description of electromagnetism as we know including elements required for signal-processing (momentum/frequency distribution/spectrum).
However, quantum field theory is formulated with application to particle physics in mind (scattering amplitudes, ...) and not quantum optics where the quantum state and unitary operators acting upon are important.

If we can "develope" quantum field theory towards a quantum optical description, we find the missing elements for communication, and because we know that quantum field theory is experimentally found, we have some confidence in these results.

## Detail the most important concepts and variables

* Quantum field theory
* Time-continuous signals
* Frequency and time domain (Fourier uncertainty)
* Bandwidth
* Single-mode quantum optics (harmonic oscillator)
* Interactions (interaction picture/Hamiltonian)
* Quantum state (coherent, number)
* Quadratures, amplitude/phase

## Briefly describe your methodology

* Derivation from first principles
* Check if results match classical expectations
* Incorporate specific literature

## Main results

### QKD

* Review of QKD from a communication protocol viewpoint
* QKD protocols have a logical quantum system and a physical-encoding quantum system.
* Logical quantum system is qubit or bosonic
* Physical-encoding quantum system often uses coherent states for practicality.

### Quantum theory of light

* Derivation and canonical quantization of Maxwell and electric field operators in the Coulomb gauge from first principles in a field-theoritcal framework.
* Axiomatic construction of continuous-mode three-dimensional quantum states.
* We recover the results reported by Vogel and Barnett for the one-dimensional Maxwell field in the Coulomb gauge.
* Assumptions: Theory is limited to stationary reference frames, fields are effectively free, 

### Quantum theory of (electro-)optical components

Quantum description (unitary operator and coherent state transformation) of
* Optical coupler and filter
* Phase and amplitude modulator
* Direct and balanced photodetectors (voltage signal of coherent state)

### Coherent state transmission system

* Signal flow through digital, analog and quantum domain

## Thesis layout/structure

### Quantum-key distribution

#### Why is it important (subject area)?

Understand the application context and background of a theoretical frameworkf for quantum optical communication.

#### What are you doing (problem definition)?

Present QKD from an abstract communication protocol perspective.

#### Where do you stop (scope)?

* No details of a particular protocol
* No particular implementation
* No security proof
* Only introduction to post-processing.

#### How do you approach the topic?

Overview of QKD protocols shows us common characteristis, which we can elaborate upon.
By showing different perspectives but keeping the description general, we do not limit ourselves to a particular implementation.
We also see that also DV-QKD lacks of a proper quantum optical framework.

### Quantum theory of light

#### Why is it important (subject area)?

Gain understanding and justification of the continuous-mode description in the quantum optics literature.

#### What are you doing (problem definition)?

Derive a continous-mode description of quantum optics from the established quantum field theoretical framework

#### Where do you stop (scope)?

* We do not consider mathematical problems of QFT
* We assume the reader to be educated in (quantum) field theory (no introduction)
* We do not present explicit proofs for all steps but rather summarize the key steps.

#### How do you approach the topic?

* Derive the Maxwell and electric field decomposed in plane-waves using classical field theory
* Perform canonical quantization
* Axiomatically construct quantum states for these fields.

### Quantum theory of (electro-)optical components

#### Why is it important (subject area)?

Apply and test the new description for physical building blocks/components of an optical communication system.

#### What are you doing (problem definition)?

Present and summarize a quantum description for important active and passive electro-optical components with particular emphasizes to coherent states.

#### Where do you stop (scope)?

We do not develope the description ourselves but use existing literature.

#### How do you approach the topic?

### Coherent state transmission system

#### Why is it important (subject area)?

Show that the framework fills a gap in the signal description.

#### What are you doing (problem definition)?

Apply the framework to a coherent state transmission system which is the foundation for many (practical) QKD protocls.

#### Where do you stop (scope)?

We assume a particular implementation of the coherent transmission system.

#### How do you approach the topic?

We show step by step how the signal flows through the transmission system.
