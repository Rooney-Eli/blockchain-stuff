# blockchain-stuff

Deployment Flow using Truffle and a local blockchain:
  1. Deploy the Client.
  2. Get the Client's address on the blockchain.
  3. Deploy the Oracle after setting the client address in the latest migration file, and be sure to set the off chain oracle to your desired off-chain oracle.
  4. Using the "Insurance provider's" account, call the initPolicy function to set the "Insurance provider's" address in the smart contract.
  5. Using the "Insurance provider's" account, call the setOracle function passing the address of the on-chain oracle's address.
  6. Using the "Policy Holder's" account, call the "makePayment" function passing in EXACTLY the agreed price for the policy.
  
  
Usage flow:
  1. using the off-chain oracle, subscribe to the RPC on the on-chain oracle to be notified of events.
  2. when an even is emited and the off-chain oracle has a response, call the on-chain oracle's updateRequest function passing in the request id, and a boolean.
 
  Should the policy time period expire, the "Insurance account" will be able to call the endPolicy function to collect the inital deposit and payment from the customer.
  Should a "house burn down" and the oracle flow complete, the "policy holder" will be able to call the claimPolicy function and collect the money. 
  
  
