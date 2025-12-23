// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * Voluntary Execution Context (VEC)
 * Minimal reference architecture
 * NOT production-ready
 */

/// @notice Registry that maps EOAs to their chosen execution context
// NOTE: This registry does NOT validate context safety or logic.
// Context security is entirely the user's responsibility.
// This contract only separates execution authority.
contract ExecutionContextRegistry {
    mapping(address => address) public contextOf;

    event ContextBound(address indexed eoa, address indexed context);
    event ContextCleared(address indexed eoa);

    /// @notice User opts into a context
    function bindContext(address context) external {
        require(context != address(0), "invalid context");
        contextOf[msg.sender] = context;
        emit ContextBound(msg.sender, context);
    }

    /// @notice User opts out
    function clearContext() external {
        delete contextOf[msg.sender];
        emit ContextCleared(msg.sender);
    }

    /// @notice Protocol check
    function requireContext(address eoa) external view {
        require(contextOf[eoa] == msg.sender, "VEC: invalid execution context");
    }
}

/// @notice Minimal execution context contract
// ExecutionContext is a scheduler / authorization layer.
// It does NOT execute protocol logic.
// Actual execution happens in the target protocol.
// Guardian logic is intentionally omitted in this minimal reference.
contract ExecutionContext {
    address public owner;        // EOA root key
    address public guardian;     // optional guardian
    uint256 public delay;        // optional timelock

    // txHash = keccak256(abi.encode(user, action, params))
    mapping(bytes32 => uint256) public queued;

    event Queued(bytes32 indexed txHash, uint256 executeAfter);
    event Executed(bytes32 indexed txHash);

    constructor(address _owner, address _guardian, uint256 _delay) {
        owner = _owner;
        guardian = _guardian;
        delay = _delay;
    }

    /// @notice Queue a high-value action
    function queue(bytes32 txHash) external {
        require(msg.sender == owner, "not owner");
        queued[txHash] = block.timestamp + delay;
        emit Queued(txHash, queued[txHash]);
    }

    /// @notice Execute after delay
    function execute(bytes32 txHash) external {
        require(msg.sender == owner, "not owner");
        require(queued[txHash] != 0, "not queued");
        require(block.timestamp >= queued[txHash], "timelock");

        delete queued[txHash];
        emit Executed(txHash);
    }
}

/// @notice Example protected protocol
contract ProtectedStaking {
    ExecutionContextRegistry public registry;

    constructor(address _registry) {
        registry = ExecutionContextRegistry(_registry);
    }

    function claim(address user) external {
        require(
            registry.isContext(user, msg.sender),
            "VEC: invalid execution context"
        );

        // claim logic here
    }
}
