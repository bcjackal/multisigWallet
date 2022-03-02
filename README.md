**Description**

- A multisig wallet is a wallet where multiple “signatures” or approvals are needed for an outgoing transfer to take place.
- As an example, I could create a multisig wallet with me and my 2 friends. I configure the wallet such that it requires at least 2 of us to sign any transfer before it is valid. Anyone can deposit funds into this wallet. But as soon as we want to spend funds, it requires 2/3 approvals.

**Requirement**

- Anyone should be able to deposit ether into the smart contract
- The contract creator should be able to input (1): the addresses of the owners and (2):  the numbers of approvals required for a transfer, in the constructor. For example, input 3 addresses and set the approval limit to 2.
- Anyone of the owners should be able to create a transfer request. The creator of the transfer request will specify what amount and to what address the transfer will be made.
- Owners should be able to approve transfer requests.
- When a transfer request has the required approvals, the transfer should be sent.

**Brainstorm**

- contracts
    - no interaction with external contract
- functions
    - able to deposit ether (everyone)
    - create transfer requests (all owners)
        - amount
        - to address
    - approve request (all owners)
        - send fund out if approvals enough
- variables
    - owners (array)
    - approvalNeeded (uint)
    - requests (array)
    - request (struct)
    - approvals (mapping owners’ address > request’s id > bool)
    - balance (mapping address from > uint amount)
- modifiers
    - for owners only
- constructor
    - address of owners
    - approvals required
- events
    - request created
    - request approved
    - fund sent
    - deposit done
- returns
    - nth

**Reference**

- [https://academy.moralis.io/lessons/project-introduction-2](https://academy.moralis.io/lessons/project-introduction-2)
- Answer : [https://academy.moralis.io/lessons/full-project-code](https://academy.moralis.io/lessons/full-project-code)
