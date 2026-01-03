Contribution Guide – Voluntary Execution Context (VEC)

Welcome! This guide explains how you can contribute to Voluntary Execution Context (VEC) and integrate it with Zero1Labs DeAI Agents.

Table of Contents
	1.	Introduction￼
	2.	How to Contribute￼
	3.	Project Structure￼
	4.	Development Guidelines￼
	5.	Testing & Validation￼
	6.	Submitting Changes￼
	7.	VEC + DeAI Agents￼

⸻

Introduction

Voluntary Execution Context (VEC) is an opt-in Ethereum execution layer designed to:
	•	Reduce the blast radius of compromised seed phrases
	•	Preserve EOA sovereignty and Ethereum core assumptions
	•	Provide a minimal, deterministic, and composable execution model for high-value actions

VEC is not a wallet, account abstraction framework, or policy engine. It separates execution authority from key ownership.

This repository welcomes contributions that improve:
	•	ECC (Execution Context Contract) functionality
	•	UX for context management
	•	Security patterns and testing
	•	Integration with DeAI Agents

⸻

How to Contribute

We appreciate contributions of all kinds, including:
	•	Bug reports & feature requests
	•	Smart contract improvements
	•	UX/UI enhancements for context management
	•	Integration with protocols (staking, DAO governance, etc.)
	•	DeAI Agent behavior, safety, and intent validation

Before starting work:
	1.	Fork the repository
	2.	Create a new branch with a descriptive name:

git checkout -b feature/context-guardian


	3.	Ensure your work aligns with VEC opt-in philosophy: nothing should force users or break EOA sovereignty.

⸻

Project Structure

/contracts        # Solidity contracts (ECC, registry, context modules)
/scripts          # Deployment and migration scripts
/tests            # Unit & integration tests
/agents           # DeAI Agent integration code
/docs             # Design docs, specifications

	•	ECC: Core Execution Context Contract
	•	Registry: Tracks valid execution contexts
	•	Modules: Guardians, timelocks, session keys

⸻

Development Guidelines
	•	Follow Solidity v0.8+ best practices
	•	Use OpenZeppelin libraries where applicable
	•	Avoid global enforcement logic; VEC is opt-in
	•	Context modules should be reversible, upgradeable, and composable
	•	Ensure Determinism: context checks must be fully predictable

⸻

Testing & Validation
	•	Unit test every module: guardian, timelock, session key
	•	Integration tests with mock protocols
	•	Test DeAI Agent integration for decision validation
	•	Recommended: simulate compromised seed scenarios to verify context enforcement

⸻

Submitting Changes
	1.	Commit with clear messages:

git commit -m "Add guardian module with time delay"


	2.	Push to your fork and create a pull request
	3.	Include tests and documentation updates
	4.	Tag PRs related to DeAI Agents clearly

⸻

VEC + DeAI Agents

Zero1Labs DeAI Agents operate inside the Execution Context, not as a root key:
	•	Seed phrase remains the root of ownership
	•	DeAI Agent validates user intent before high-value actions
	•	Agent may interact with guardians, timelocks, and session keys
	•	This reduces human error, phishing, or accidental execution risks

Example: For a DAO claim, the agent ensures that the request aligns with prior user intent and any configured delay before execution.

Important: The agent is optional. Users may interact directly with the ECC if preferred.

⸻

Key Principles
	•	Always opt-in
	•	Preserve user freedom and EOA sovereignty
	•	Keep contexts modular and reversible
	•	Never assume that a seed alone grants operational authority

⸻

This contribution guide is designed to make VEC development safe, clear, and compatible with Ethereum’s ethos, while enabling next-generation intelligent security with DeAI Agents.

⸻
