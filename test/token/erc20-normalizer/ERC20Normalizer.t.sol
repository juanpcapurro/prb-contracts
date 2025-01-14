// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.19 <0.9.0;

import { IERC20 } from "src/token/erc20/IERC20.sol";

import { ERC20NormalizerMock } from "../../shared/ERC20NormalizerMock.t.sol";
import { Base_Test } from "../../Base.t.sol";

/// @notice Common logic needed by all {ERC20Normalizer} unit tests.
abstract contract ERC20Normalizer_Test is Base_Test {
    /*//////////////////////////////////////////////////////////////////////////
                                     CONSTANTS
    //////////////////////////////////////////////////////////////////////////*/

    uint256 internal constant STANDARD_DECIMALS = 18;
    uint256 internal constant USDC_SCALAR = 10 ** 12;

    /*//////////////////////////////////////////////////////////////////////////
                                   TEST CONTRACTS
    //////////////////////////////////////////////////////////////////////////*/

    ERC20NormalizerMock internal erc20Normalizer = new ERC20NormalizerMock();
}
