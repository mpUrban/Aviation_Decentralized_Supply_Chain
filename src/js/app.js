App = {
    web3Provider: null,
    contracts: {},
    emptyAddress: "0x0000000000000000000000000000000000000000",
    sku: 0,
    sn: 0,
    metamaskAccountID: "0x0000000000000000000000000000000000000000",
    ownerID: "0x0000000000000000000000000000000000000000",
    originShopID: "0x0000000000000000000000000000000000000000",
    originShopName: null,
    originShopInformation: null,
    originShopLatitude: null,
    originShopLongitude: null,
    productNotes: null,
    productPrice: 0,
    distributorID: "0x0000000000000000000000000000000000000000",
    storeID: "0x0000000000000000000000000000000000000000",
    buyerID: "0x0000000000000000000000000000000000000000",

    init: async function () {
        App.readForm();
        /// Setup access to blockchain
        return await App.initWeb3();
    },

    readForm: function () {
        App.sku = $("#sku").val();
        App.sn = $("#sn").val();
        App.ownerID = $("#ownerID").val();
        App.originShopID = $("#originShopID").val();
        App.originShopName = $("#originShopName").val();
        App.originShopInformation = $("#originShopInformation").val();
        App.originShopLatitude = $("#originShopLatitude").val();
        App.originShopLongitude = $("#originShopLongitude").val();
        App.productNotes = $("#productNotes").val();
        App.productPrice = $("#productPrice").val();
        App.distributorID = $("#distributorID").val();
        App.retailerID = $("#retailerID").val();
        App.consumerID = $("#consumerID").val();

        console.log(
            App.sku,
            App.sn,
            App.ownerID, 
            App.originShopID, 
            App.originShopName, 
            App.originShopInformation, 
            App.originShopLatitude, 
            App.originShopLongitude, 
            App.productNotes, 
            App.productPrice, 
            App.distributorID, 
            App.retailerID, 
            App.consumerID
        );
    },















    initWeb3: async function () {
        /// Find or Inject Web3 Provider
        /// Modern dapp browsers...
        if (window.ethereum) {
            App.web3Provider = window.ethereum;
            try {
                // Request account access
                await window.ethereum.enable();
            } catch (error) {
                // User denied account access...
                console.error("User denied account access")
            }
        }
        // Legacy dapp browsers...
        else if (window.web3) {
            App.web3Provider = window.web3.currentProvider;
        }
        // If no injected web3 instance is detected, fall back to Ganache
        else {
            App.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
        }

        App.getMetaskAccountID();

        return App.initSupplyChain();
    },

    getMetaskAccountID: function () {
        web3 = new Web3(App.web3Provider);

        // Retrieving accounts
        web3.eth.getAccounts(function(err, res) {
            if (err) {
                console.log('Error:',err);
                return;
            }
            console.log('getMetaskID:',res);
            App.metamaskAccountID = res[0];

        })
    },

    initSupplyChain: function () {
        /// Source the truffle compiled smart contracts
        var jsonSupplyChain='sc/build/contracts/SupplyChain.json';
        
        /// JSONfy the smart contracts
        $.getJSON(jsonSupplyChain, function(data) {
            console.log('data',data);
            var SupplyChainArtifact = data;
            App.contracts.SupplyChain = TruffleContract(SupplyChainArtifact);
            App.contracts.SupplyChain.setProvider(App.web3Provider);
            
            App.fetchItemBufferOne();
            App.fetchItemBufferTwo();
            App.fetchEvents();

        });

        return App.bindEvents();
    },

    bindEvents: function() {
        $(document).on('click', App.handleButtonClick);
    },

    handleButtonClick: async function(event) {
        event.preventDefault();

        App.getMetaskAccountID();

        var processId = parseInt($(event.target).data('id'));
        console.log('processId',processId);

        switch(processId) {
            case 1:
                return await App.removeItem(event);
                break;
            case 2:
                return await App.cleanInspectItem(event);
                break;
            case 3:
                return await App.shipItem(event);
                break;
            case 4:
                return await App.receiveItem(event);
                break;
            case 5:
                return await App.inspectItem(event);
                break;
            case 6:
                return await App.repairItem(event);
                break;
            case 7:
                return await App.buyItem(event);
                break;
            case 8:
                return await App.fetchItemBufferOne(event);
                break;
            case 9:
                return await App.fetchItemBufferTwo(event);
                break;
            }
    },














    removeItem: function(event) {
        event.preventDefault();
        var processId = parseInt($(event.target).data('id'));

        App.contracts.SupplyChain.deployed().then(function(instance) {
            return instance.removeItem(
                App.sn, 
                App.metamaskAccountID, 
                App.originShopName, 
                App.originShopInformation, 
                App.originShopLatitude, 
                App.originShopLongitude, 
                App.productNotes
            );
        }).then(function(result) {
            $("#ftc-item").text(result);
            console.log('removeItem',result);
        }).catch(function(err) {
            console.log(err.message);
        });
    },

    cleanInspectItem: function (event) {
        event.preventDefault();
        var processId = parseInt($(event.target).data('id'));

        App.contracts.SupplyChain.deployed().then(function(instance) {
            return instance.cleanInspectItem(App.sn, {from: App.metamaskAccountID});
        }).then(function(result) {
            $("#ftc-item").text(result);
            console.log('cleanInspectItem',result);
        }).catch(function(err) {
            console.log(err.message);
        });
    },

    shipItem: function (event) {
        event.preventDefault();
        var processId = parseInt($(event.target).data('id'));

        App.contracts.SupplyChain.deployed().then(function(instance) {
            return instance.shipItem(App.sn, {from: App.metamaskAccountID});
        }).then(function(result) {
            $("#ftc-item").text(result);
            console.log('shipItem',result);
        }).catch(function(err) {
            console.log(err.message);
        });
    },






    receiveItem: function (event) {
        event.preventDefault();
        var processId = parseInt($(event.target).data('id'));

        App.contracts.SupplyChain.deployed().then(function(instance) {
            const productPrice = web3.toWei(1, "ether");
            console.log('productPrice',productPrice);
            return instance.receiveItem(App.sn, App.productPrice, {from: App.metamaskAccountID});
        }).then(function(result) {
            $("#ftc-item").text(result);
            console.log('receiveItem',result);
        }).catch(function(err) {
            console.log(err.message);
        });
    },









    inspectItem: function (event) {
        event.preventDefault();
        var processId = parseInt($(event.target).data('id'));

        App.contracts.SupplyChain.deployed().then(function(instance) {
            return instance.inspectItem(App.sn, {from: App.metamaskAccountID});
        }).then(function(result) {
            $("#ftc-item").text(result);
            console.log('inspectItem',result);
        }).catch(function(err) {
            console.log(err.message);
        });
    },

    repairItem: function (event) {
        event.preventDefault();
        var processId = parseInt($(event.target).data('id'));

        App.contracts.SupplyChain.deployed().then(function(instance) {
            return instance.repairItem(App.sn, {from: App.metamaskAccountID});
        }).then(function(result) {
            $("#ftc-item").text(result);
            console.log('repairItem',result);
        }).catch(function(err) {
            console.log(err.message);
        });
    },





    buyItem: function (event) {
        event.preventDefault();
        var processId = parseInt($(event.target).data('id'));

        App.contracts.SupplyChain.deployed().then(function(instance) {
            const walletValue = web3.toWei(3, "ether");
            return instance.buyItem(App.sn, {from: App.metamaskAccountID, value: walletValue});
        }).then(function(result) {
            $("#ftc-item").text(result);
            console.log('buyItem',result);
        }).catch(function(err) {
            console.log(err.message);
        });
    },


    fetchItemBufferOne: function () {
    ///   event.preventDefault();
    ///    var processId = parseInt($(event.target).data('id'));
        App.sn = $('#sn').val();
        console.log('sn',App.sn);

        App.contracts.SupplyChain.deployed().then(function(instance) {
          return instance.fetchItemBufferOne(App.sn);
        }).then(function(result) {
          $("#ftc-item").text(result);
          console.log('fetchItemBufferOne', result);
        }).catch(function(err) {
          console.log(err.message);
        });
    },

    fetchItemBufferTwo: function () {
    ///    event.preventDefault();
    ///    var processId = parseInt($(event.target).data('id'));
                        
        App.contracts.SupplyChain.deployed().then(function(instance) {
          return instance.fetchItemBufferTwo.call(App.sn);
        }).then(function(result) {
          $("#ftc-item").text(result);
          console.log('fetchItemBufferTwo', result);
        }).catch(function(err) {
          console.log(err.message);
        });
    },

    fetchEvents: function () {
        if (typeof App.contracts.SupplyChain.currentProvider.sendAsync !== "function") {
            App.contracts.SupplyChain.currentProvider.sendAsync = function () {
                return App.contracts.SupplyChain.currentProvider.send.apply(
                App.contracts.SupplyChain.currentProvider,
                    arguments
              );
            };
        }

        App.contracts.SupplyChain.deployed().then(function(instance) {
        var events = instance.allEvents(function(err, log){
          if (!err)
            $("#ftc-events").append('<li>' + log.event + ' - ' + log.transactionHash + '</li>');
        });
        }).catch(function(err) {
          console.log(err.message);
        });
        
    }
};

$(function () {
    $(window).load(function () {
        App.init();
    });
});