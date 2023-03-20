// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/birthdayBoy.sol";
contract CounterTest is Test, Birthday {


    function setUp() public {

    }

    function testIncrement(uint256 prankTimestamp) public {
        assertEq(1==1, 1==1);

    }

}
