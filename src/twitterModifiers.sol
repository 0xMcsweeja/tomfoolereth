pragma solidity ^0.8.0;

contract twitterUserGroups {
    // User group enumeration to optimize storage and gas costs.
    enum UserGroupType {
        None,
        Elon,
        PowerUser,
        Democrat,
        Republican
    }

    // A single mapping to store user group information for each address.
    mapping(address => uint8) public userGroup;

    // Immutable variable for the contract deployer.
    address public immutable deployer;

    // Custom error to reduce gas costs and make the error messages more concise.
    error NotAuthorized(UserGroupType requiredGroup);

    constructor() {
        deployer = msg.sender;
    }

    // Modifier to restrict function access to "Elon" user group only.
    modifier onlyElon() {
        if (userGroup[msg.sender] != uint8(UserGroupType.Elon)) revert NotAuthorized(UserGroupType.Elon);
        _;
    }

    // Modifier to restrict function access to "PowerUser" user group only.
    modifier onlyPowerUser() {
        if (userGroup[msg.sender] != uint8(UserGroupType.PowerUser)) revert NotAuthorized(UserGroupType.PowerUser);
        _;
    }

    // Modifier to restrict function access to "Democrat" user group only.
    modifier onlyDemocrat() {
        if (userGroup[msg.sender] != uint8(UserGroupType.Democrat)) revert NotAuthorized(UserGroupType.Democrat);
        _;
    }

    // Modifier to restrict function access to "Republican" user group only.
    modifier onlyRepublican() {
        if (userGroup[msg.sender] != uint8(UserGroupType.Republican)) revert NotAuthorized(UserGroupType.Republican);
        _;
    }

    // Set the user group for an address (only callable by the deployer).
    function setUserGroup(address user, UserGroupType group) external {
        require(msg.sender == deployer, "Only the elon can set user groups.");
        userGroup[user] = uint8(group);
    }
}
