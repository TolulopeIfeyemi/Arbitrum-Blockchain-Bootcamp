// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract GaslessTokenTransfer is ERC20 {
    // This mapping is used to prevent replay attacks. However, it uses the signature as the key,
    // which means that if a user signs two different transactions with the same nonce but different parameters,
    // the second transaction will fail because the signature has already been used.
    mapping(bytes => bool) public usedNonces;

    constructor() ERC20("GaslessToken", "GST") {
        _mint(msg.sender, 10000 * (10 ** uint256(decimals())));
    }

    function transferPreSigned(bytes memory _signature, address _to, uint256 _value, uint256 _fee, uint256 _nonce) public returns (bool) {
        bytes32 hashedTx = keccak256(abi.encodePacked(this, _to, _value, _fee, _nonce));
        address from = recover(hashedTx, _signature);

        // This check prevents replay attacks, but as mentioned above, it's not sufficient because it uses the signature as the key.
        require(!usedNonces[_signature]);
        usedNonces[_signature] = true;

        // The contract is potentially vulnerable to a reentrancy attack because it calls the `_transfer` function
        // (an external function whose code we don't see here) twice in a row without any checks in between.
        // If the `_transfer` function isn't written properly, it could potentially call back into `transferPreSigned`
        // before the first invocation of `_transfer` has finished.
        _transfer(from, _to, _value);
        _transfer(from, msg.sender, _fee);

        return true;
    }

    function recover(bytes32 _hash, bytes memory _sig) public pure returns (address) {
        bytes32 r;
        bytes32 s;
        uint8 v;

        assembly {
            r := mload(add(_sig, 32))
            s := mload(add(_sig, 64))
            v := byte(0, mload(add(_sig, 96)))
        }

        return ecrecover(_hash, v, r, s);
    }
}
