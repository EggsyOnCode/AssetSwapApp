require("dotenv").config();
const api_key = process.env.MORALIS_API;

// server.js
const express = require("express");
const Moralis = require("moralis").default;
const { isAddress } = require("web3-validator");
const { Web3 } = require("web3");
const { EvmChain } = require("@moralisweb3/common-evm-utils");
const app = express();
const port = 3000;

// Define your endpoint
app.get("/get_balance_tokens", async (req, res) => {
  // Handle the request and send a response
  try {
    if (!Moralis.Core.isStarted) {
      await Moralis.start({
        apiKey: api_key,
      });
    }

    const addressx = req.query.address;

    const chain = EvmChain.GOERLI;

    const response = await Moralis.EvmApi.balance.getNativeBalance({
      address: addressx,
      chain: chain,
    });

    res.json(response);
  } catch (e) {
    console.error(e);
  }
});

app.get("/address_check", async (req, res) => {
  // Handle the request and send a response
  try {
    if (!Moralis.Core.isStarted) {
      await Moralis.start({
        apiKey: api_key,
      });
    }

    const addressx = req.query.address;

    const result = isAddress(addressx);

    res.json(result);
  } catch (e) {
    console.error(e);
  }
});

//endpoint to retrieve wallet agaisnt its private key
app.get("/fetch_wallet", async (req, res) => {
  // Handle the request and send a response
  try {
    const pvkey = req.query.pvkey;

    const rpcEndpoint =
      "https://eth-goerli.g.alchemy.com/v2/bP7U4Z7H7v1qMXSfdyQYR-odhgb5Sa6N";
    const web3 = new Web3(new Web3.providers.HttpProvider(rpcEndpoint));

    const getAccounts = async () => {
      // To get all accounts
      let accounts = await web3.eth.getAccounts();

      // To get accounts with private key (this line remains unchanged)
      let isValid = await web3.eth.accounts.privateKeyToAccount("0x" + pvkey);
      console.log(isValid);
      return isValid;
    };

    const isAddress = await getAccounts();

    res.json(isAddress);
  } catch (e) {
    res.send(false);
    console.error(e);
  }
});

// Start the server
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
