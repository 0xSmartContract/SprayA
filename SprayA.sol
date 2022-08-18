// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "../../lib/test.sol";
import "../../lib/Console.sol";

contract GasTest is DSTest {
    Contract0 c0;
    Contract1 c1;
    
    function setUp() public {
        c0 = new Contract0();
        c1 = new Contract1();
    }
    
    function testGas() public {
        address payable[] memory Inputs = new address payable[](6);
        Inputs[0] = payable(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
        Inputs[1] = payable(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2);
        Inputs[2] = payable(0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db);
        Inputs[3] = payable(0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB);
        Inputs[4] = payable(0x617F2E2fD72FD9D5503197092aC168c91465E7f2);
        Inputs[5] = payable(0x17F6AD8Ef982297579C203069C1DbfFE4348c372);
        
        c0.Spray(Inputs);
        c1.Spray(Inputs);
    }
}

contract Contract0 {
        function Spray(address payable[] calldata targets) payable external {
        uint n = targets.length;
        for (uint i = 0; i < n;) {
            targets[i].call{value: 1, gas: 0}("");
            unchecked {
                ++i;
            }
        }
    }
}

contract Contract1 { 
     function Spray(address payable[] calldata targets) payable external {
        uint n = targets.length;
        for (uint i = 0; i < n;) {
            targets[i].call{value: 1, gas: 0}("");
            unchecked {
                i = unchecked_inc(i);
            }
        }
    }

    
    function unchecked_inc(uint i) internal pure returns (uint) {
        unchecked {
            return i + 1;
        }
    }
}
