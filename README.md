# PDDL Problem Formulations
*Collection of PDDL problem formulations for various planning tasks*

<p align="center">
  <img alt="last-commit" src="https://img.shields.io/github/last-commit/tatoken/PDDLProblem?style=flat&logo=git&logoColor=white&color=0080ff">
  <img alt="repo-top-language" src="https://img.shields.io/github/languages/top/tatoken/PDDLProblem?style=flat&color=0080ff">
  <img alt="repo-language-count" src="https://img.shields.io/github/languages/count/tatoken/PDDLProblem?style=flat&color=0080ff">
  <img alt="PDDL" src="https://img.shields.io/badge/PDDL-005FAD?style=flat&logo=data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg'%3E%3C/svg%3E">
  <img alt="Text files" src="https://img.shields.io/badge/Text%20files-000000?style=flat&logo=txt&logoColor=white">
</p>


*This repository contains a collection of PDDL problem formulations for various planning tasks.*

<p align="center">
  <img alt="PDDL" src="https://img.shields.io/badge/PDDL-005FAD.svg?style=flat&logo=code&logoColor=white">
  <img alt="GitHub" src="https://img.shields.io/badge/GitHub-181717.svg?style=flat&logo=GitHub&logoColor=white">
</p>

---

## Table of Contents
- [Overview](#overview)
- [Structure](#structure)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Usage](#usage)

---

## Overview
This repository provides a collection of PDDL problem formulations for various planning tasks. Each problem is defined in a separate file and follows the standard PDDL format.

---

## Structure
The repository is organized as follows:

/pddl-problems
├── Blockword/
│ ├── domain.pddl
│ ├── problem.pddl
├── DieciCampi/
│ ├── homework/
│ ├───── domain.pddl
│ ├───── problem.pddl
│ ├───── solution.txt
│ └── ....
├── Hanoi/
│ ├── domain.pddl
│ └── problem.pddl
└── README.md

---

## Getting Started

### Prerequisites
To work with these PDDL problem formulations, you need:

- **PDDL-compatible planner**: Such as [Fast Downward](https://github.com/aibasel/downward) or [Metric-FF](http://www.cs.uni-potsdam.de/ff/).
- **Text editor**: Any text editor to view or modify the PDDL files.

###Usage
To use a problem formulation, select a .pddl file from the repository and provide it as input to your PDDL planner. For example:
```sh
fast-downward.py --alias seq-sat-lama-2011 Blockword/domain.pddl
```

