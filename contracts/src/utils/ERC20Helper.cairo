use starknet::ContractAddress;
use data_dao::utils::ERC20::{ERC20ABIDispatcher, ERC20ABIDispatcherTrait};

pub fn balanceOf(token: ContractAddress, address: ContractAddress) -> u256 {
    dispatcher(token).balanceOf(address)
}

fn dispatcher(token: ContractAddress) -> ERC20ABIDispatcher {
    ERC20ABIDispatcher {contract_address: token}
}

pub fn approve(token: ContractAddress, spender: ContractAddress, amount: u256) {
    if (amount!=0) {
        let approved = dispatcher(token).approve(spender, amount);
        assert(approved, 'Approval failed');
        //// println!(">>>> Approved tokens");
    }
}

pub fn transfer_from(token: ContractAddress, from: ContractAddress, to: ContractAddress, amount: u256) {
    if (amount!=0) {
        let transferred = dispatcher(token).transferFrom(from, to, amount);
        assert(transferred, 'Transfer  failed');
        //// println!(">>>> Transferfrom {:?} tokens", amount);
    }
}

pub fn strict_transfer_from(token: ContractAddress, from: ContractAddress, to: ContractAddress, amount: u256) {
    assert(amount!=0, 'TransferFrm: Amt 0');
    transfer_from(token, from, to, amount);
}

pub fn transfer(token: ContractAddress, to: ContractAddress, amount: u256) {
    if (amount!=0) {
        let transferred = dispatcher(token).transfer(to, amount);
        assert(transferred, 'Transfer failed');
        //// println!(">>>> Transfered {:?} tokens", amount);
    }
}

pub fn strict_transfer(token: ContractAddress, to: ContractAddress, amount: u256) {
    assert(amount!=0, 'Transfer: Amt 0');
    transfer(token, to, amount);
}

pub fn decimals(token: ContractAddress) -> u8 {
    dispatcher(token).decimals()
}
