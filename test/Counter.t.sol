// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/birthdayBoy.sol";
contract CounterTest is Test, Birthday {


    function setUp() public {

    }

    function testIncrement(uint256 prankTimestamp) public {
        vm.warp(b);
        uint256 comparable = 163;
        uint256 doy = DateLib.getDayOfYear(prankTimestamp);
        console.log(comparable);
        console.log(doy);
        require(doy == comparable);

    }

}
