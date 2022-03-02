pragma solidity 0.8.7;

contract Wallet {

    struct Request {
        uint id;
        address creator;
        address payable to;
        uint amount;
        uint approvals;
        bool hasBeenSent;
    }

    // ["0x5B38Da6a701c568545dCfcB03FcB875f56beddC4", "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2", "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db"]
    uint approvalNeeded;
    address[] owners;
    Request[] requests;
    mapping(address => uint) balance;
    mapping(address => mapping(uint => bool)) approvals;

    event requestCreated(uint id, address creator, address to, uint amount);
    event requestApproved(uint id, address approver);
    event fundSent(uint id, uint amount);
    event depositDone(address from, uint amount);

    modifier onlyOwners {
        bool isOwner = false;

        for (uint i = 0; i < owners.length; i++) {
            if (msg.sender == owners[i]) {
                isOwner = true;
            }
        }

        require(isOwner == true, "You are not the owners!");
        _;
    }

    constructor(address[] memory _owners, uint _approvalNeeded) {
        owners = _owners;
        approvalNeeded = _approvalNeeded;
    }   

    function deposit() public payable {
        balance[msg.sender] += msg.value;
        emit depositDone(msg.sender, msg.value);
    } 

    function createRequest(address payable _to, uint _amount) public onlyOwners {
        requests.push(Request(requests.length, msg.sender, _to, _amount, 0, false));
        emit requestCreated(requests.length, msg.sender, _to, _amount);
    }

    function approveRequest(uint _id) public onlyOwners {
        require(approvals[msg.sender][_id] == false, "You already approved.");
        require(requests[_id].hasBeenSent == false, "The fund has been sent out already.");

        approvals[msg.sender][_id] = true;
        requests[_id].approvals++;
        emit requestApproved(_id, msg.sender);

        if (requests[_id].approvals >= approvalNeeded) {
            require(address(this).balance >= requests[_id].amount, "Insufficient fund to transfer.");
            requests[_id].to.transfer(requests[_id].amount);

            requests[_id].hasBeenSent = true;
            emit fundSent(_id, requests[_id].amount);
        }
    }

}
