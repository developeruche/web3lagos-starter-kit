// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


// Stage 1: Smart contract design and concept evaluation
// This smart is a vault smart contact that can hold any ERC20 token, and it can also hold native-token.
// deposititor can deposit any ERC20 token or native-token into the vault, and the depositor can also withdraw any ERC20 token or native-token from the vault.
// The vault smart contract will also have a function to transfer any ERC20 token from the vault to any address.

// Stage 2: Smart contract Interfacing
interface VaultInterface {
    function depositERC20(address _token, uint256 _amount) external;
    function depositNative() external payable; // msg.value
    function withdrawERC20(address _token, uint256 _amount) external;
    function withdrawNative(uint256 _amount) external;
    function transferERC20(address _token, address _to, uint256 _amount) external;
}

// we would be using this interface to interact with the ERC20 token
interface IERC20 {
    function transfer(address to, uint256 value) external returns (bool);
    function transferFrom(address from, address to, uint256 value) external returns (bool);
    function approve(address spender, uint256 value) external returns (bool);
    function balanceOf(address who) external view returns (uint256);
}

//------
// for learning purpose, we would be using the USDC token
// IERC20 usdc = IERC20(address_usdc);
// usdc.transferFrom(msg.sender, address(this), amount);
//------

// Stage 3: Smart contract implementation
contract Vault is VaultInterface {
    // state variables 
    // this is mapping [User address] => [Token address] => [Token balance] stores the balance of each user for each token
    mapping(address => mapping (address => uint256)) public balancesERC20;
    //this is a mapping [User address] => [Native balance] stores the balance of each user for native token
    mapping(address => uint256) public balancesNative;



    // events
    event DepositERC20(address indexed user, address indexed token, uint256 amount);
    event DepositNative(address indexed user, uint256 amount);
    event WithdrawERC20(address indexed user, address indexed token, uint256 amount);
    event WithdrawNative(address indexed user, uint256 amount);
    event TransferERC20(address indexed user, address indexed to, address indexed token, uint256 amount);





    function depositERC20(address _token, uint256 _amount) external override {
        // transfer this token from the user to the contract (also learning how to perform cross contract interaction)
        IERC20 token = IERC20(_token);
        address from = msg.sender;
        address to = address(this);

        token.transferFrom(from, to, _amount); // at this point, the tokens are transferred from the user to the contract
        
        
        // increase the balance of the user for this token
        balancesERC20[from][_token] += _amount;


        // emit event for this transaction with the vault
        emit DepositERC20(from, _token, _amount);
    }

    function depositNative() external payable override {
        // get the amout  of native token sent in by this user (by using msg.value)
        uint256 nativeAmountDepostited = msg.value;
        address from = msg.sender;

        // increase the balance of the user for native token
        balancesNative[from] += nativeAmountDepostited;

        // emit event for this transaction with the vault
        emit DepositNative(from, nativeAmountDepostited);
    }


    /// Assignments {}
    function withdrawERC20(address _token, uint256 _amount) external override {
        // check is this user have this balance they are trying to withdraw
        // decrease the balance of the user for this token
        // transfer this token from the contract to the user
        // emit event for this transaction with the vault
    }

    function withdrawNative(uint256 _amount) external override {
        address from = msg.sender;
        // check is this user have this balance they are trying to withdraw
        require(balancesNative[from] >= _amount, "Vault: insufficient balance");

        // decrease the balance of the user for native token
        balancesNative[from] -= _amount;

        // transfer this native token from the contract to the user
        // call (recommended)
        (bool success, ) = payable(from).call{value: _amount}("");


        // emit event for this transaction with the vault
        emit WithdrawNative(from, _amount);
    }

    function transferERC20(
        address _token,
        address _to,
        uint256 _amount
    ) external override {
        address owner = msg.sender;
        // check is this user have this balance they are trying to transfer
        require(balancesERC20[owner][_token] >= _amount, "Vault: insufficient balance");


        // decrease the balance of the user for this token
        balancesERC20[owner][_token] -= _amount;

        // sent this token from the contract to the user (_to)
        IERC20 token = IERC20(_token);
        token.transfer(_to, _amount);

        // emit event for this transaction with the vault
        emit TransferERC20(owner, _to, _token, _amount);
    }
}




        // // require
        // require(balancesNative[from] >= _amount, "Vault: insufficient balance");
        // // assert
        // assert(balancesNative[from] >= _amount);
        // // revert
        // if(balancesNative[from] < _amount) {
        //     revert("Vault: insufficient balance");
        // }
        // tranfer (highly discouraged)
        // payable(from).transfer(_amount);