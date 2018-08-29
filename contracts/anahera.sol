pragma solidity ^0.4.8;

contract admined {
  address public admin;

  constructor() public {
    admin = msg.sender;
  }

  modifier onlyAdmin() {
    require(
      msg.sender == admin,
      "Sender not authorized"
    );
    _;
  }

  function transferAdminship(address newAdmin) public onlyAdmin {
    admin = newAdmin;
  }
}

contract AnaheraCoin {
  mapping (address => uint256) public balanceOf;
  mapping (address => mapping(address=> uint256)) public allowance;
  string public standard = "AnaheraCoin";
  string public name;
  string public symbol;
  uint8 public decimals;
  uint256 public totalSupply;
  event Transfer(address indexed from, address indexed to, uint value);

  constructor(uint256 initialSupply, string tokenName, string tokenSymbol, uint8 decimalUnits) public {
    balanceOf[msg.sender] = initialSupply;
    totalSupply = initialSupply;
    name = tokenName;
    symbol = tokenSymbol;
    decimals = decimalUnits;
  }

  function transfer(address _to, uint256 _value) public {
    require(
      balanceOf[msg.sender] >= _value,
      "Insufficient funds"
      );
    require(
      balanceOf[_to] + _value >= balanceOf[_to],
      "Initial balance is higher than current balance"
    );
    balanceOf[msg.sender] -= _value;
    balanceOf[_to] += _value;
    emit Transfer(msg.sender, _to, _value);
  }

  function approve(address _spender, uint256 _value) public view returns (bool success) {
    allowance[msg.sender][_spender] >= _value;
    return true;
  }

  function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
    require(
      balanceOf[_from] >= _value,
      "Insufficient funds"
    );
    require(
      balanceOf[_to] + _value >= balanceOf[_to],
      "Initial balance is higher than current balance"
    );
    balanceOf[_from] -= _value;
    balanceOf[_to] += _value;
    allowance[_from][msg.sender] -= _value;
    emit Transfer(_from, _to, _value);
    return true;
  }
}
