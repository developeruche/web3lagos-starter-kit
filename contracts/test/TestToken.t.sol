// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {TestToken} from "../src/Token.sol";




contract TestTokenTest is Test {
    TestToken public token;

    function setUp() public {
        token = new TestToken(
            "TestToken",
            "TST",
            1000000 ether,
            address(this)
        );
    }

    function test_transfer() public {
        token.transfer(0x57E17Ec08f7b4a6eB8eF98b6C26Ef90f5512Fb67, 1 ether);
        uint256 bal = token.balanceOf(0x57E17Ec08f7b4a6eB8eF98b6C26Ef90f5512Fb67);
        assertEq(bal, 1 ether);
    }
}
