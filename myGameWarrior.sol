pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "myGameMilitaryUnit.sol";

contract myGameWarrior is myGameMilitaryUnit {

    constructor(uint hit, uint defence, uint health) public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        militaryUnit.hit = hit;
        militaryUnit.defence = defence;
        militaryUnit.health = health;
    }

    function getHit() internal override checkAccept view returns(uint) {
        return militaryUnit.hit;
    }

    function getDefence() internal override checkAccept view returns(uint) {
        return militaryUnit.defence;
    }

    function checkHit() public view returns(uint) {
        return getHit();
    }

    function checkDefence() public view returns(uint) {
        return getDefence();
    }

    function getHealth() internal override checkAccept view returns(uint) {
        return militaryUnit.health;
    }

    function checkHealth() public view returns(uint) {
        return getHealth();
    }

    function attackEnemy(myGameMilitaryUnit militaryUnit) public{
        uint valDamage = getHit();
        militaryUnit.getAttack(valDamage);
    }
}
