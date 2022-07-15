pragma solidity ^0.8.1;
// FeeForMinting
// Only Approved Users can mint
// metadata is passed as an argument for every mint
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract nft_contract is ERC1155, Ownable, ReentrancyGuard {

    uint256 public Token_Id = 0;
    uint256 public feeForAbilityToMint = 0.1 ether;
    mapping(address => bool) public is_User_approved_to_mint; 
    mapping(uint256 => string) _uris;

    modifier approved_to_mint() {
        require(is_User_approved_to_mint[_msgSender()], "You have to be approved in order to mint tokens");
        _;
    }
    constructor(string memory initial_uri) ERC1155(initial_uri) {
        _mint(_msgSender(), Token_Id, 1, "");
        Token_Id +=1;
        is_User_approved_to_mint[_msgSender()] = true;
    }

  function _setURI(string memory newuri) internal override {
      _uris[Token_Id] = newuri;
    }
    

    function mint(string memory newuri) public approved_to_mint nonReentrant{
        _mint(_msgSender(), Token_Id, 1, "");
        _setURI(newuri);
        Token_Id +=1;

    }
    function approve_user_to_mint() public payable {
        require(msg.value >= feeForAbilityToMint);
        is_User_approved_to_mint[_msgSender()] =true;
    }
    function uri(uint256 id) public view override returns (string memory) {
        return _uris[id];
    }
    
    function withdraw_minting_fees() public onlyOwner {
        payable(_msgSender()).transfer(address(this).balance);
    }

    receive() external payable {
        
    }
}