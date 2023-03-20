// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract restnow {

    // defined constants for the start and end hours of the restricted period
    // and a bit mask to extract the hour from the timestamp. The modifier uses these
    // constants and the bitwise AND operator to extract the current hour and check
    // if it falls within the restricted period. 
    uint256 hour = block.timestamp / 3600 % 24;
    uint256 constant REST_START_HOUR = 23;
    uint256 constant REST_END_HOUR = 6;
    uint256 constant HOUR_MASK = 0x1f; // 0b11111

    modifier restNow() {
        uint256 currentHour = (block.timestamp / 3600) & HOUR_MASK;
        require(currentHour >= REST_START_HOUR || currentHour < REST_END_HOUR, "rest now");
        _;
    }

    modifier weekdaysOnly() {
        uint256 dayOfWeek = ((block.timestamp / 86400) + 4) % 7; // 0 = Sunday, 6 = Saturday
        require(dayOfWeek >= 1 && dayOfWeek <= 5, "Function can only be called on weekdays");
        _;
    }

    uint256 constant WEEKDAY_START_HOUR = 9;
    uint256 constant WEEKDAY_END_HOUR = 17;

    modifier bidnessHours() {
        uint256 currentHour = (block.timestamp / 3600) & HOUR_MASK;
        uint256 dayOfWeek = ((block.timestamp / 86400) + 4) % 7; // 0 = Sunday, 6 = Saturday
        require(dayOfWeek >= 1 && dayOfWeek <= 5 && currentHour >= WEEKDAY_START_HOUR && currentHour < WEEKDAY_END_HOUR, "Function can only be called on weekdays between 9am and 5pm");
        _;
}

modifier primeSeconds() {
    uint256 currentSecond = block.timestamp % 60;

    bool isPrime = true;
    if (currentSecond <= 1) {
        isPrime = false;
    } else {
        for (uint256 i = 2; i <= currentSecond / 2; i++) {
            if (currentSecond % i == 0) {
                isPrime = false;
                break;
            }
        }
    }

    require(isPrime, "Function can only be called during prime seconds");
    _;
}

modifier fullMoonOnly() {
    uint256 moonCycleDuration = 29.53 days;
    uint256 fullMoonTimestamp = 1619740800;
    uint256 timeSinceLastFullMoon = (block.timestamp - fullMoonTimestamp) % moonCycleDuration;
    require(timeSinceLastFullMoon < 1 days, "Function can only be called during a full moon");
    _;
}



}