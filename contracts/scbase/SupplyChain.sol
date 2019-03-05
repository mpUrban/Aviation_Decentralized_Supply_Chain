pragma solidity ^0.4.24;
// Define a contract 'Supplychain'
contract SupplyChain {

  // Define 'owner'
  address owner;

  // Define a variable called 'sn' for Serial Number (SN)
  uint  sn;

  // Define a variable called 'sku' for Stock Keeping Unit (SKU)
  uint  sku;

  // Define a public mapping 'items' that maps the SN to an Item.
  mapping (uint => Item) items;

  // Define a public mapping 'itemsHistory' that maps the SN to an array of TxHash, 
  // that track its journey through the supply chain -- to be sent from DApp.
  mapping (uint => string[]) itemsHistory;
  
  // Define enum 'State' with the following values:
  enum State 
  { 
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
  struct Item {
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
  modifier verifyCaller (address _address) {
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








//  WORKING HERE
// define modifiers
// define data to store
// define fcns




  // Define a modifier that checks if an item.state of a sn is Removed
  modifier removed(uint _sn) {
    require(items[_sn].itemState == State.Harvested);
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
    require(items[_sn].itemState == State.Purchased;
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
  function removeItem(uint _sn, address _originShopID, string _originShopName, string _originShopInformation, string  _originShopLatitude, string  _originShopLongitude, string  _productNotes) public 
  {
    // Add the new item as part of Removal
    
    // Increment sku
    sku = sku + 1;
    // Emit the appropriate event
    emit Removed(sn);
    
  }

  // Define a function 'cleanInspectItem' that allows a shop to mark an item 'CleanInspect'
  function cleanInspectItem(uint _sn) public 
  // Call modifier to check if sn has passed previous supply chain stage
  
  // Call modifier to verify caller of this function
  
  {
    // Update the appropriate fields
    
    // Emit the appropriate event
    
  }

  // Define a function 'shipItem' that allows a shop to mark an item 'Shipped'
  function shipItem(uint _sn) public 
  // Call modifier to check if sn has passed previous supply chain stage
  
  // Call modifier to verify caller of this function
  
  {
    // Update the appropriate fields
    
    // Emit the appropriate event
    
  }

  // Define a function 'receiveItem' that allows a shop to mark an item 'Received'
  function receiveItem(uint _sn, uint _price) public 
  // Call modifier to check if sn has passed previous supply chain stage
  
  // Call modifier to verify caller of this function
  
  {
    // Update the appropriate fields
    
    // Emit the appropriate event
    
  }

  // Define a function 'inspectItem' that allows a shop to mark an item 'Inspected'
  function inspectItem(uint _sn, uint _price) public 
  // Call modifier to check if sn has passed previous supply chain stage
  
  // Call modifier to verify caller of this function
  
  {
    // Update the appropriate fields
    
    // Emit the appropriate event
    
  }

  // Define a function 'repairItem' that allows a shop to mark an item 'Repaired'
  function repairItem(uint _sn, uint _price) public 
  // Call modifier to check if sn has passed previous supply chain stage
  
  // Call modifier to verify caller of this function
  
  {
    // Update the appropriate fields
    
    // Emit the appropriate event
    
  }


  // Define a function 'buyItem' that allows the store to mark an item 'Purchased'
  // Use the above defined modifiers to check if the item is available for sale, if the buyer has paid enough, 
  // and any excess ether sent is refunded back to the buyer
  function buyItem(uint _sn) public payable 
    // Call modifier to check if sn has passed previous supply chain stage
    
    // Call modifer to check if buyer has paid enough
    
    // Call modifer to send any excess ether back to buyer
    
    {
    
    // Update the appropriate fields - ownerID, storeID, itemState
    
    // Transfer money to shop
    
    // emit the appropriate event
    
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
  string  originShopLongitude
  ) 
  {
  // Assign values to the 8 parameters
  
    
  return 
  (
  itemSKU,
  itemSN,
  ownerID,
  originShopID,
  originShopName,
  originShopInformation,
  originShopLatitude,
  originShopLongitude
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
  uint    itemState,
  address storeID,
  address retailerID,
  address buyerID
  ) 
  {
    // Assign values to the 9 parameters
  
    
  return 
  (
  itemSKU,
  itemSN,
  productID,
  productNotes,
  productPrice,
  itemState,
  storeID,
  retailerID,
  buyerID
  );
  }
}
