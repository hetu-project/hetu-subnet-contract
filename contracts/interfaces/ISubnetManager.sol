// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./ISubnetTypes.sol";

/**
 * @title ISubnetManager
 * @dev Interface for subnet manager
 */
interface ISubnetManager {
    
    // ============ Events ============
    
    /**
     * @dev Subnet registration event
     */
    event NetworkRegistered(
        uint16 indexed netuid,
        address indexed owner,
        address alphaToken,
        address ammPool,
        uint256 lockedAmount,
        uint256 poolAmount,
        uint256 burnedAmount,
        string name,
        SubnetTypes.SubnetHyperparams hyperparams
    );
    
    event SubnetActivated(
        uint16 indexed netuid,
        address indexed owner,
        uint256 timestamp,
        uint256 blockNumber
    );

    
    // ============ Core Functions ============
    
    /**
     * @dev Register new subnet
     * @param name Subnet name
     * @param description Subnet description
     * @param tokenName Alpha token name
     * @param tokenSymbol Alpha token symbol
     * @return netuid Assigned subnet ID
     */
    function registerNetwork(
        string calldata name,
        string calldata description,
        string calldata tokenName,
        string calldata tokenSymbol
    ) external returns (uint16 netuid);
    
    /**
     * @dev Transfer subnet ownership
     * @param netuid Subnet ID
     * @param newOwner New owner address
     */
    // function transferSubnetOwnership(uint16 netuid, address newOwner) external;
    

    
    // ============ View Functions ============
    
    /**
     * @dev Get all subnets owned by user
     * @param user User address
     * @return Array of subnet IDs
     */
    function getUserSubnets(address user) external view returns (uint16[] memory);
    
    /**
     * @dev Get subnet detailed information
     * @param netuid Subnet ID
     * @return subnetInfo Basic subnet information
     * @return currentPrice Current price
     * @return totalVolume Total trading volume
     * @return hetuReserve HETU reserve amount
     * @return alphaReserve Alpha reserve amount
     */
    function getSubnetDetails(uint16 netuid) external view returns (
        SubnetTypes.SubnetInfo memory subnetInfo,
        uint256 currentPrice,
        uint256 totalVolume,
        uint256 hetuReserve,
        uint256 alphaReserve
    );

    /**
     * @dev Check if subnet active
     * @param netuid Subnet ID
     * @return isActive True if subnet is active
     */
    function isSubnetActive(uint16 netuid) external view returns (bool);
    
    /**
     * @dev Get subnet basic information
     * @param netuid Subnet ID
     * @return Subnet information struct
     */
    function getSubnetInfo(uint16 netuid) external view returns (SubnetTypes.SubnetInfo memory);
    
    /**
     * @dev Get subnet hyperparameters
     * @param netuid Subnet ID
     * @return Subnet hyperparameters struct
     */
    function getSubnetParams(uint16 netuid) external view returns (SubnetTypes.SubnetHyperparams memory);
    
    /**
     * @dev Get network lock cost
     * @return Current lock cost required for subnet registration
     */
    function getNetworkLockCost() external view returns (uint256);
    
    /**
     * @dev Get next available subnet ID
     * @return Next available netuid
     */
    function getNextNetuid() external view returns (uint16);
    
    /**
     * @dev Check if subnet exists
     * @param netuid Subnet ID
     * @return Whether exists
     */
    function subnetExists(uint16 netuid) external view returns (bool);
    
    // ============ Network Parameters ============
    
    /**
     * @dev Get network parameters
     */
    function networkMinLock() external view returns (uint256);
    function networkLastLock() external view returns (uint256);
    function networkLastLockBlock() external view returns (uint256);
    function networkRateLimit() external view returns (uint256);
    function lockReductionInterval() external view returns (uint256);
    function totalNetworks() external view returns (uint16);
    function nextNetuid() external view returns (uint16);
    
}
