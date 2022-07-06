pragma solidity ^0.8.1;
// FeeForMinting
// Only Approved Users can mint
// metadata is passed as an argument for every mint
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract nft_contract is ERC1155, Ownable, ReentrancyGuard {
    uint256 Token_id = 0;
    uint256 Fee_for_minting = 0.1 ether;
    mapping(address => bool) public Approved_users_to_mint;
    mapping(uint256 => string) public _uris;


    modifier is_user_approved {
        require(Approved_users_to_mint[_msgSender()], "You need to be approved to mint tokens");
        _;
    }

    constructor(string memory zero_id_uri) ERC1155(zero_id_uri) {
        emit URI(zero_id_uri , Token_id);
        Token_id += 1;
        Approved_users_to_mint[_msgSender()] = true;
    }

    function _setURI(string memory newuri) override internal {
        _uris[Token_id] = newuri;
    }

    function uri(uint256 id) public override view returns(string memory) {
        return _uris[id];
    }

    function mint(string memory newuri) public nonReentrant is_user_approved{
        _mint(_msgSender(), Token_id, 1, "");
        _setURI(newuri);
        emit URI(newuri , Token_id);
        Token_id +=1;
    }

    function approve_user_to_mint() public payable {

        require(msg.value >= Fee_for_minting, "You must pay a fee for ability to mint");
        Approved_users_to_mint[_msgSender()] = true;

    }

    function withdraw_minting_fees() payable public onlyOwner {

        payable(_msgSender()).transfer(address(this).balance);

    }

    receive() external payable {
    }

}