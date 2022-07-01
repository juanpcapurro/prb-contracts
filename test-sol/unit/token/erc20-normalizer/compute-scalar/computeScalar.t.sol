// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.4;

import { IERC20 } from "@prb/contracts/token/erc20/IERC20.sol";
import { ERC20GodMode } from "@prb/contracts/token/erc20/ERC20GodMode.sol";
import { ERC20Normalizer } from "@prb/contracts/token/erc20/ERC20Normalizer.sol";
import { IERC20Normalizer } from "@prb/contracts/token/erc20/IERC20Normalizer.sol";

import { ERC20NormalizerUnitTest } from "../ERC20NormalizerUnitTest.t.sol";

contract ERC20Normalizer__ComputeScalar__UnitTest is ERC20NormalizerUnitTest {
    ERC20GodMode internal tkn19 = new ERC20GodMode("Token 19", "TKN19", 19);
    ERC20GodMode internal tkn255 = new ERC20GodMode("Token 255", "TKN18", 255);

    /// @dev When the token decimals are zero, it should revert.
    function testCannotComputeScalar__TokenDecimalsZero() external {
        vm.expectRevert(abi.encodeWithSelector(IERC20Normalizer.IERC20Normalizer__TokenDecimalsZero.selector, tkn0));
        erc20Normalizer.computeScalar(tkn0);
    }

    /// @dev When the token decimals are greater than 18, it should revert.
    function testCannotComputeScalar__TokenDecimalsGreaterThan18__19() external {
        uint256 decimals = 19;
        vm.expectRevert(
            abi.encodeWithSelector(
                IERC20Normalizer.IERC20Normalizer__TokenDecimalsGreaterThan18.selector,
                tkn19,
                decimals
            )
        );
        erc20Normalizer.computeScalar(tkn19);
    }

    /// @dev When the token decimals are greater than 18, it should revert.
    function testCannotComputeScalar__TokenDecimalsGreaterThan18__255() external {
        uint256 decimals = 255;
        vm.expectRevert(
            abi.encodeWithSelector(
                IERC20Normalizer.IERC20Normalizer__TokenDecimalsGreaterThan18.selector,
                tkn255,
                decimals
            )
        );
        erc20Normalizer.computeScalar(tkn255);
    }

    /// @dev When the token decimals are equal to 18, it should compute the scalar.
    function testComputeScalar__TokenDecimalsEqualTo18() external {
        erc20Normalizer.computeScalar(dai);
        uint256 actualScalar = erc20Normalizer.getScalar(dai);
        uint256 expectedScalar = 1;
        assertEq(actualScalar, expectedScalar);
    }

    /// @dev When the token decimals are less than 18, it should compute the scalar.
    function testComputeScalar__TokenDecimalsLessThan18() external {
        erc20Normalizer.computeScalar(usdc);
        uint256 actualScalar = erc20Normalizer.getScalar(usdc);
        uint256 expectedScalar = 10**(18 - usdc.decimals());
        assertEq(actualScalar, expectedScalar);
    }
}