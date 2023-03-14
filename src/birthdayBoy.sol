// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

library DateLib {
    // Returns the number of days since epoch for a given timestamp
    function getDaysSinceEpoch(uint256 timestamp) internal pure returns (uint256) {
        return timestamp / 86400;
    }

    // Returns the day of the year (0-indexed) for a given timestamp
    function getDayOfYear(uint256 timestamp) internal pure returns (uint256) {
        uint256 daysSinceEpoch = getDaysSinceEpoch(timestamp);
        uint256 year = 1970 + daysSinceEpoch / 365;
        if (isLeapYear(year)) {
            return (daysSinceEpoch % 366);
        } else {
            return (daysSinceEpoch % 365);
        }
    }

    // Returns true if the given year is a leap year, false otherwise
    function isLeapYear(uint256 year) internal pure returns (bool) {
        if (year % 4 != 0) {
            return false;
        } else if (year % 100 != 0) {
            return true;
        } else if (year % 400 != 0) {
            return false;
        } else {
            return true;
        }
    }
}

contract Birthday {
    using DateLib for uint256;

    uint256 constant APRIL_22 = 112; // April 22 is the 112th day of the year (0-indexed)
    uint256 constant HOUR_MASK = 0x1f; // 0b11111

    // Modifier that only allows the function to be called on April 22nd
    modifier birthdayBoy() {
        uint256 dayOfYear = block.timestamp.getDayOfYear();
        require(dayOfYear == APRIL_22, "Function can only be called on April 22nd");
        _;
    }
}
