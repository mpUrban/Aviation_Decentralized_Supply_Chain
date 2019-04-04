pragma solidity ^ 0.4.24;
// Define a contract 'Supplychain'
contract SupplyChain {

    // Define 'owner'
    address owner;

    // Define a variable called 'sn' for Serial Number (SN)
    uint  sn;

    // Define a variable called 'sku' for Stock Keeping Unit (SKU)
    uint  sku;

    // Define a public mapping 'items' that maps the SN to an Item.
    mapping(uint => Item) items;

    // Define a public mapping 'itemsHistory' that maps the SN to an array of TxHash, 
    // that track its journey through the supply chain -- to be sent from DApp.
    mapping(uint => string[]) itemsHistory;

    // Define enum 'State' with the following values:
    enum State {
        Removed,      // 0
        CleanInspect, // 1
        Shipped,      // 2
        Received,     // 3
        Inspected,    // 4
        Repaired,     // 5
        Purchased     // 6
    }

    State constant defaultState = State.Removed;




    // Define a struct 'Item' with the following fields:
    struct Item
    {
        uint    sku;  // Stock Keeping Unit (SKU)
        uint    sn; // Serial Number (SN), recorded by the Shop, goes on the package, can be verified by the Consumer
        address ownerID;  // Metamask-Ethereum address of the current owner as the product moves through 7 stages
        address originShopID; // Metamask-Ethereum address of the Shop
        string  originShopName; // Shop Name
        string  originShopInformation;  // Shop Information
        string  originShopLatitude; // Shop Latitude
        string  originShopLongitude;  // Shop Longitude
        uint    productID;  // Product ID potentially a combination of sn + sku       //part number?
        string  productNotes; // Product Notes
        uint    productPrice; // Product Price
        State   itemState;  // Product State as represented in the enum above
        address storeID;  // Metamask-Ethereum address of the Distributor
        address buyerID; // Metamask-Ethereum address of the Consumer
    }






    // Define 7 events with the same 8 state values and accept 'sn' as input argument
    event Removed(uint sn);
    event CleanInspect(uint sn);
    event Shipped(uint sn);
    event Received(uint sn);
    event Inspected(uint sn);
    event Repaired(uint sn);
    event Purchased(uint sn);








    // Define a modifer that checks to see if msg.sender == owner of the contract
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    // Define a modifer that verifies the Caller
    modifier verifyCaller(address _address) {
        require(msg.sender == _address);
        _;
    }

    // Define a modifier that checks if the paid amount is sufficient to cover the price
    modifier paidEnough(uint _price) {
        require(msg.value >= _price);
        _;
    }

    // Define a modifier that checks the price and refunds the remaining balance
    modifier checkValue(uint _sn) {
        _;
        uint _price = items[_sn].productPrice;
        uint amountToReturn = msg.value - _price;
        items[_sn].buyerID.transfer(amountToReturn);
    }






    //  STATE MODIFIERS

    // Define a modifier that checks if an item.state of a sn is Removed
    modifier removed(uint _sn) {
        require(items[_sn].itemState == State.Removed);
        _;
    }

    // Define a modifier that checks if an item.state of a sn is CleanInspect
    modifier cleaninspect(uint _sn) {
        require(items[_sn].itemState == State.CleanInspect);
        _;
    }

    // Define a modifier that checks if an item.state of a sn is Shipped
    modifier shipped(uint _sn) {
        require(items[_sn].itemState == State.Shipped);
        _;
    }

    // Define a modifier that checks if an item.state of a sn is Received
    modifier received(uint _sn) {
        require(items[_sn].itemState == State.Received);
        _;
    }

    // Define a modifier that checks if an item.state of a sn is Inspected
    modifier inspected(uint _sn) {
        require(items[_sn].itemState == State.CleanInspect);
        _;
    }

    // Define a modifier that checks if an item.state of a sn is Repaired
    modifier repaired(uint _sn) {
        require(items[_sn].itemState == State.Repaired);
        _;
    }

    // Define a modifier that checks if an item.state of a sn is Purchased
    modifier purchased(uint _sn) {
        require(items[_sn].itemState == State.Purchased);
        _;
    }









    // In the constructor set 'owner' to the address that instantiated the contract
    // and set 'sku' to 1
    // and set 'sn' to 1
    constructor() public payable {
        owner = msg.sender;
        sku = 1;
        sn = 1;
    }

    // Define a function 'kill' if required
    function kill() public {
        if (msg.sender == owner) {
            selfdestruct(owner);
        }
    }








    // Define a function 'removeItem' that allows a shop to mark an item 'Removed'
    function removeItem(uint _sn, address _originShopID, string memory _originShopName, string memory _originShopInformation, string memory  _originShopLatitude, string memory  _originShopLongitude, string memory  _productNotes) public
    verifyCaller(_originShopID)
    // only shop role can call this function?  

    {
        // Check SN is new
        require(items[_sn].sn == 0, "SN already exists");


        // Add the new item as part of Removal
        Item memory newItem;
        newItem.sku = sku;
        newItem.sn = _sn;
        //ownerID = msg.sender;
        newItem.originShopID = msg.sender;
        newItem.originShopName = _originShopName;
        newItem.originShopInformation = _originShopInformation;
        newItem.originShopLatitude = _originShopLatitude;
        newItem.originShopLongitude = _originShopLongitude;
        newItem.productID = _sn; // add PN?
        newItem.productNotes = _productNotes;
        // newItem.productPrice = 0; // placeholder = to be updated following inspection?
        newItem.itemState = State.Removed;
        // newItem.storeID; // placeholder
        // newItem.buyerID; // placeholder

        // Increment sku
        sku = sku + 1;

        // Update mapping
        items[_sn] = newItem;

        // Emit the appropriate event
        emit Removed(sn);

    }

    // Define a function 'cleanInspectItem' that allows a shop to mark an item 'CleanInspect'
    function cleanInspectItem(uint _sn) public

    // Call modifier to check if sn has passed previous supply chain stage (is removed)
    removed(_sn)

    // Call modifier to verify caller of this function
    verifyCaller(items[_sn].originShopID)

    {
        // Update the appropriate fields
        items[_sn].itemState = State.CleanInspect;

        // Emit the appropriate event
        emit CleanInspect(_sn);

    }

    // Define a function 'shipItem' that allows a shop to mark an item 'Shipped'
    function shipItem(uint _sn) public
    // Call modifier to check if sn has passed previous supply chain stage
    cleaninspect(_sn)

    // Call modifier to verify caller of this function
    verifyCaller(items[_sn].originShopID)

    {
        // Update the appropriate fields
        items[_sn].itemState = State.Shipped;

        // Emit the appropriate event
        emit Shipped(_sn);

    }

    // Define a function 'receiveItem' that allows a shop to mark an item 'Received'
    function receiveItem(uint _sn, uint _price) public
    // Call modifier to check if sn has passed previous supply chain stage
    shipped(_sn)

    // Call modifier to verify caller of this function
    verifyCaller(items[_sn].originShopID)

    {
        // Update the appropriate fields
        items[_sn].itemState = State.Received;

        // Emit the appropriate event
        emit Received(_sn);

    }

    // Define a function 'inspectItem' that allows a shop to mark an item 'Inspected'
    function inspectItem(uint _sn, uint _price) public
    // Call modifier to check if sn has passed previous supply chain stage
    received(_sn)

    // Call modifier to verify caller of this function
    verifyCaller(items[_sn].originShopID)

    {
        // Update the appropriate fields
        items[_sn].itemState = State.Inspected;

        // Emit the appropriate event
        emit Inspected(_sn);

    }

    // Define a function 'repairItem' that allows a shop to mark an item 'Repaired'
    function repairItem(uint _sn, uint _price) public
    // Call modifier to check if sn has passed previous supply chain stage
    inspected(_sn)

    // Call modifier to verify caller of this function
    verifyCaller(items[_sn].originShopID)

    {
        // Update the appropriate fields
        items[_sn].itemState = State.Repaired;

        // Emit the appropriate event
        emit Repaired(_sn);

    }


    // Define a function 'buyItem' that allows the store to mark an item 'Purchased'
    // Use the above defined modifiers to check if the item is available for sale, if the buyer has paid enough, 
    // and any excess ether sent is refunded back to the buyer
    function buyItem(uint _sn) public payable
    // Call modifier to check if sn has passed previous supply chain stage
    repaired(_sn)

    // Call modifer to check if buyer has paid enough
    paidEnough(items[_sn].productPrice)

    // Call modifer to send any excess ether back to buyer
    checkValue(_sn)



    {

        // Update the appropriate fields - ownerID, storeID, itemState
        items[_sn].ownerID = msg.sender;
        items[_sn].buyerID = msg.sender;
        items[_sn].itemState = State.Purchased;

        // Transfer money to shop
        items[_sn].storeID.transfer(items[_sn].productPrice);


        // emit the appropriate event
        emit Purchased(_sn);

    }



    // Define a function 'fetchItemBufferOne' that fetches the data
    function fetchItemBufferOne(uint _sn) public view returns
        (
            uint    itemSKU,
            uint    itemSN,
            address ownerID,
            address originShopID,
            string  originShopName,
            string  originShopInformation,
            string  originShopLatitude,
            string  originShopLongitude,
            string  productNotes
        )
    {
        itemSKU = items[_sn].sku;
        itemSN = items[_sn].sn;
        ownerID = items[_sn].ownerID;
        originShopID = items[_sn].originShopID;
        originShopName = items[_sn].originShopName;
        originShopInformation = items[_sn].originShopInformation;
        originShopLatitude = items[_sn].originShopLatitude;
        originShopLongitude = items[_sn].originShopLongitude;
        productNotes = items[_sn].productNotes;

        return
        (
            itemSKU,
            itemSN,
            ownerID,
            originShopID,
            originShopName,
            originShopInformation,
            originShopLatitude,
            originShopLongitude,
            productNotes
        );
    }

    // Define a function 'fetchItemBufferTwo' that fetches the data
    function fetchItemBufferTwo(uint _sn) public view returns
        (
            uint    itemSKU,
            uint    itemSN,
            uint    productID,
            string  productNotes,
            uint    productPrice,
            State    itemState,
            address storeID,
            address buyerID
        )
    {
        
        itemSKU = items[_sn].sku;
        itemSN = items[_sn].sn;
        productID = items[_sn].productID;
        productNotes = items[_sn].productNotes;
        productPrice = items[_sn].productPrice;
        itemState = items[_sn].itemState;
        storeID = items[_sn].storeID;
        buyerID = items[_sn].buyerID;
        
        return
        (
            itemSKU,
            itemSN,
            productID,
            productNotes,
            productPrice,
            itemState,
            storeID,
            buyerID
        );
    }
}
