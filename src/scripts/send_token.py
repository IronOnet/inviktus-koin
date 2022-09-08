from brownie import accounts, config, Contract, Inviktus 
from scripts.utils import get_account

ADDRESS = ""
RECIPIENT = "" 
AMOUNT = "0"


def main(): 
    account = get_account() 
    erc20_address = ADDRESS 
    recipient = RECIPIENT 
    amount = AMOUNT 
    erc20 = Contract.from_abi("Inviktus Token", erc20_address, abi=Inviktus.abi) 
    tx = erc20.transfer(recipient, amount, {"from": account}) 
    tx.wait(1) 