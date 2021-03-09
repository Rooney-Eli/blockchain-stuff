pragma solidity ^0.7.4;


contract Client {
    //used for ABI interaction
    function initPolicy() public {}
    function makePayment(uint256 amount) public {}
    function setOracle(address _onChainOracle) public {}
    function setHouseBurnedDown(bool _houseBurnedDown) public {}
    function endPolicy() public {}
    function claimPolicy() public {}
}



contract Oracle {

    address clientAdr;         //Address of client contract
    address offChainOracle; // GO request router address, MAY BE DIFFERENT DEPENDING ON BLOCKCHAIN. 
    Client client;

    constructor(
        address _clientAdr,
        address _offChainOracle
    ) {
        offChainOracle = _offChainOracle;
        client = Client(_clientAdr);
        clientAdr = _clientAdr;
    }
 
    Request[] requests; // List of requests made to the contract. Needed for deterministic nature of blockchain.
    uint currentId = 0; 

    struct Request {
        uint id;        //request id
        string key;     //key to fetch value from off-chain oracle
        bool value;     //result from off-chain oracle
        
    }

    event NewRequest (
         uint id,
         string key
    );

    event UpdatedRequest(
        uint id,
        string key,
        bool value
    );

    function setHouseBurnedDown(bool _houseBurnedDown) public{
        client.setHouseBurnedDown(_houseBurnedDown);
    }


    function createRequest(
        string memory _key
    ) public {
        requests.push(Request(currentId, "", false));

        emit NewRequest (
            currentId,
            _key
        );

        currentId++;
    }

    function updateRequest(
        uint _id,
        bool _value
    ) public {
    
        Request storage currentRequest = requests[_id];

        emit UpdatedRequest (
              currentRequest.id,
              currentRequest.key,
              _value
            );

        if(_value) {
            setHouseBurnedDown(_value);
        }
    }

    
}

