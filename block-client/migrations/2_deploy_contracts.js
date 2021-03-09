var Client = artifacts.require("./Client.sol");

module.exports = function(deployer) {
    /*  Client constructor arguments:
        uint256 _policyAmount,
        uint256 _policyPrice,
        uint256 _policyDuration
    */


    var policyAmount = 100000;
    var requiredPayment = 100;
    var time = 2592000; //2,592,000 = 30 days in UNIX time 
    

    deployer.deploy(Client, policyAmount, requiredPayment, time)


    //client pubkey: 0x0a19528E38F071E2F8E2DADbD71cf3c5A7Ed579B, private: 3484b814ebff5d7c38b3c14bb5c6aaab17309f678438727589214fd65f43dcd1
    //insurance PubKey: 0xFE8726e2Bda27907198253d3348fA4CF927c3de6, private: bd8dfaa02d62192923596b39f5cccaa81bb63fd9791f9bc39fcb5515a6c675b6
    //geth pubkey: 0xd50149e2f451be3FB57994D6d1699027Cb7878C7 , private: 47a1b0409ed5abdc164a824fb1a3ee8fc9fbd26bae803b6f43ac2c016c43b1bc


};
