// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.8;
import "./priceConverter.sol";

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;
    uint256 public constant minimumUSD = 5 * 1e18;
    address[] public  funders;
    mapping(address => uint256) addressToAmountFunded;
    address public immutable owner;

    constructor(){
        owner = msg.sender;

    }

    function fund() public payable{
        require(msg.value.getConversionRate() >= minimumUSD, "Did not send enough ether!");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function withdraw() public onlyOwner{
        
        for(uint256 index = 0; index < funders.length; index++){
          address funder = funders[index];
          addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0); // reset array

        // transfer , send or call
        // payable(msg.sender).transfer(address(this).balance);

        // bool success = payable(msg.sender).send(address(this).balance);
        // require(success, "Send Failed");

        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed");

    }

    modifier onlyOwner {
        // if(msg.sender != owner) { revert NotOwner(); } 
        require(msg.sender == owner, "Sender is not owner");
        _;
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
   
}