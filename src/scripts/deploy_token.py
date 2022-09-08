from brownie import accounts, config, Inviktus 
from scripts.utils import get_account 

initial_supply = 1_000_000_000_000 # 1 Trillions Inviktuses as initial supply 
token_name = "Inviktus" 
token_symbol = "IVK" 

def main(): 
    account = get_account() 
    erc20 = Inviktus.deploy(
        initial_supply, token_name, token_symbol, {"from": account}
    )