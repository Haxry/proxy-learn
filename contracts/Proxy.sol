//spdX-License-Identifier: MIT

pragma solidity ^0.8.4;

import {StorageSlot} from "./StorageSlot.sol";

contract Proxy{
  bytes32 private constant _IMPL_SLOT =
        bytes32(uint256(keccak256("eip1967.proxy.implementation")) - 1);
    //address public implementation;

    function setImplementation(address implementation_) public {
      StorageSlot.setAddressAt(_IMPL_SLOT, implementation_);
    }

    function getImplementation() public view returns (address) {
      return StorageSlot.getAddressAt(_IMPL_SLOT);
    }

   fallback() external {
  _delegate(StorageSlot.getAddressAt(_IMPL_SLOT));
}

function _delegate(address impl) internal virtual {
  assembly {
      let ptr := mload(0x40)
      calldatacopy(ptr, 0, calldatasize())

      let result := delegatecall(gas(), impl, ptr, calldatasize(), 0, 0)

      
  }

}

}