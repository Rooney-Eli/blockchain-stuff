pragma solidity ^0.7.4;


contract Client {

    uint256 public policyAmount;
    uint256 public policyPrice;
    uint256 public policyEndTime;
    bool ended;

    bool houseBurnedDown = false;

    address payable public insuranceProvider;
    address payable public policyHolder;
    address onChainOracle;


    constructor(
        uint256 _policyAmount,      // USD$
        uint256 _policyPrice,       // USD$
        uint256 _policyDuration    // UNIX time
    ) {
        policyAmount = _policyAmount;
        policyPrice = _policyPrice;
        policyEndTime = block.timestamp + _policyDuration;
    }

    event PolicyEnded(address insuranceProvider, uint256 policyAmount, uint256 payment);
    event PolicyClaimed(address policyHolder, uint256 policyAmount, uint256 payment);

    function initPolicy() public {
        insuranceProvider = msg.sender;
    }

    function makePayment(uint256 amount) public {
        require(amount == policyPrice);
        policyHolder = msg.sender;
    }

    //call with offChain address and pass the oracle ether for gas
    function setOracle(address _onChainOracle) public {
        require(msg.sender == insuranceProvider, "You may not choose the oracle.");
        onChainOracle = _onChainOracle;
    }

    function setHouseBurnedDown(bool _houseBurnedDown) public {
        require( msg.sender == onChainOracle, "Only the oracle can know this");
        houseBurnedDown = _houseBurnedDown;
    }

    function endPolicy() public {
        require( msg.sender ==  insuranceProvider, "Only the provider is allowed to end.");
        require(block.timestamp >= policyEndTime, "Period not yet expired.");
        require(!ended, "endPolicy has already been called.");

        ended = true;

        emit PolicyEnded(insuranceProvider, policyAmount, policyPrice);

        insuranceProvider.transfer(policyPrice + policyAmount);
    }

    function claimPolicy() public {
        require(block.timestamp <= policyEndTime, "Period expired.");
        require(!ended, "Policy has already ended.");
        require(houseBurnedDown, "House hasn't burned down");

        ended = true;
        houseBurnedDown = true;

        emit PolicyClaimed(policyHolder, policyAmount, policyPrice);

        policyHolder.transfer(policyPrice + policyAmount);
    }
}
