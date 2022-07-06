

const assert = require('assert')
const ganache = require('ganache-cli');
const Web3 = require('web3')
const web3 = new Web3(ganache.provider())

const instance_of_nft = require('../build/contracts/nft_contract.json');

let accounts;
let nft_instance;
let address_of_the_contract;

beforeEach( async ()=> {

    accounts = await web3.eth.getAccounts();

    nft_instance = await new web3.eth.Contract(instance_of_nft.abi).deploy({
        data: instance_of_nft.bytecode, arguments:["initial_uri"]}).send({from: accounts[0], gas: "5000000"});


    address_of_the_contract = await nft_instance._address;
    


})

it('deploys a contract', ()=> {

    assert.ok(address_of_the_contract)
})