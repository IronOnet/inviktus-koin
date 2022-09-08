//SPDX-License-Identifier: MIT 

pragma solidity ^0.8.13; 

interface tokenRecipient{
    function receiveApproval(address _from, uint256 _value, address _token, bytes calldata _extraData) external;
}


contract InviktusToken{
    // Public Variables 
    string public name; 
    string public symbol; 
    uint8 public decimals = 18; 

    uint256 public totalSupply; 

    // This creates an array with all balances 
    mapping(address => uint256) public balanceOf; 
    mapping(address => mapping (address => uint256)) public allowance; 

    // This event will notify clients 
    event Transfer(address indexed from, address indexed to, uint256 value); 

    // This event will also notify clients 
    event Approval(address indexed _owner, address indexed _spender, uint256 _value); 

    // This notifies the client about the amount burnt 
    event Burn(address indexed from, uint256 value); 


    /**
    Initializes the smart contract with the initial supply of tokens 
    to the creator of the contract
     */ 
     constructor(
        uint256 initialSupply, 
        string memory tokenName, 
        string memory tokenSymbol 
     ) public {
        totalSupply = initialSupply * 10 ** uint256(decimals); 
        balanceOf[msg.sender] = totalSupply; 
        name = tokenName; 
        symbol = tokenSymbol; 
     }


     /**
     Internal transfer, this can only be called by this contract
      */
      function _transfer(address _from, address _to, uint _value) internal{
        // prevent Transfer to 0x0 address. Use burn() instead() 
        require(_to != address(0x0)); 
        // check if sender has enough 
        require(balanceOf[_from] >= _value); 
        // check for overflows 
        require(balanceOf[_to] + _value >= balanceOf[_to]); 
        // Save this for an assertion in the future 
        uint previousBalances = balanceOf[_from] + balanceOf[_to]; 
        // subtract from the sender 
        balanceOf[_from] -= _value; 

        // Add the same to the recipient 
        balanceOf[_to] += _value; 
        emit Transfer(_from, _to, _value); 
        // Asserts are used to use static analysis to find bugs in the code. 
        assert(balanceOf[_from] + balanceOf[_to] == previousBalances); 
      }



      /**
        Transfer tokens 
        Send `_value` tokens to `_to` from your account 
        @param _to the address of the recipient 
        @param _value the amount sent
       */
       function transfer(address _to, uint256 _value) public returns (bool success){
            _transfer(msg.sender, _to, _value); 
            return true; 
       }

       /**
       Transfer tokens from other address 
       
       send `_value`tokens to `to`on behalf of `_from */ 
       function transferFrom(address _from, address _to, uint256 _value) public returns(bool success){
        require(_value <= allowance[_from][msg.sender]); // check allowance 
        allowance[_from][msg.sender] -= value; 
        _transfer(_from, _to, _value); 
        return true; 
       }
}