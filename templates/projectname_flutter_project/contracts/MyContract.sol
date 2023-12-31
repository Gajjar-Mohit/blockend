// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StringStorage {
    // State variable to store the string value
    string private storedString;

    // Event emitted when the string is set
    event StringSet(string newValue);

    // Function to set the string value
    function setString(string memory newValue) public {
        storedString = newValue;
        emit StringSet(newValue);
    }

    // Function to get the stored string value
    function getString() public view returns (string memory) {
        return storedString;
    }
}
